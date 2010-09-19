require 'net/smtp'
require 'smtp_tls'

class Emailer
  USERNAME = 'user.name'
  EMAIL_ADDR_THAT_SENDS_EM = "#{USERNAME}@gmail.com"
  PASSWORD = 'P4zzW0rd!'
  FROM    = %Q|"EmailOMatic Reminder Service" <#{EMAIL_ADDR_THAT_SENDS_EM}>|

  def initialize(reminder_email_formatter = ReminderEmailFormatter.new)
    @reminder_email_formatter = reminder_email_formatter
  end

  def send_email(reminders, recipients)
    recipients.each do |recipient|
      email = format_email(reminders, recipient)
      send_email_via_smtp(email, recipient.email_address)
    end
  end

  private

  def format_email(reminders, recipient)
    message_body = @reminder_email_formatter.format_due_reminders_for_email(reminders)

    <<MESSAGE_END
From:    #{FROM}
To: "   #{recipient.name}   " <   #{recipient.email_address}   >
Subject: EmailOMatic Reminder Service

   #{message_body}
MESSAGE_END
  end

  def send_email_via_smtp(message, email_address)
    Net::SMTP.start('smtp.gmail.com', 587, 'localhost.localdomain', USERNAME, PASSWORD, 'plain') do |smtp|
      smtp.send_message(message, EMAIL_ADDR_THAT_SENDS_EM, email_address)
    end
  end

end