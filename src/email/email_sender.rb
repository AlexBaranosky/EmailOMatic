require 'net/smtp'
require File.dirname(__FILE__) + '/reminder_email_creator'

#TODO: Mail gem?
class EmailSender
  USERNAME = 'user.name'
  SENDER_EMAIL = "#{USERNAME}@gmail.com"
  PASSWORD = 'P4zzW0rd!'

  def send_email(message, destination_email_address)
    smtp = Net::SMTP.new('smtp.gmail.com', 587)
    smtp.enable_starttls
    smtp.start('localhost.localdomain', USERNAME, PASSWORD, 'plain') do |connection|
      connection.send_message(message, SENDER_EMAIL, destination_email_address)
    end
  end
end