require 'net/smtp'
require File.dirname(__FILE__) + '/reminder_email_formatter'

class Emailer
  USERNAME = 'user.name'
  SENDER_EMAIL = "#{USERNAME}@gmail.com"
  PASSWORD = 'P4zzW0rd!'
  FROM    = %Q|"EmailOMatic Reminder Service" <#{SENDER_EMAIL}>|

  def send_email(reminders, recipients)
    recipients.each do |recipient|
      email = format_email(reminders, recipient)
      send_email_via_smtp(email, recipient.email_address)
    end
  end

  private

  def format_email(reminders, recipient)
    message_body = ReminderEmailFormatter.new.format_due_reminders_for_email(reminders)

    <<MESSAGE_END
From:     #{FROM}
To: "    #{recipient.name}    " <    #{recipient.email_address}    >
Subject: EmailOMatic Reminder Service

    #{message_body}
MESSAGE_END
  end

  def send_email_via_smtp(message, destination_email)
    smtp = Net::SMTP.new('smtp.gmail.com', 587)
    smtp.enable_starttls
    smtp.start('localhost.localdomain', USERNAME, PASSWORD, 'plain') do |connection|
      connection.send_message(message, SENDER_EMAIL, destination_email)
    end
  end

end