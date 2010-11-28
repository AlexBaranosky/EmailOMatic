require File.dirname(__FILE__) + '/../src/reminder/reminder_loader'
require File.dirname(__FILE__) + '/../src/parsing/cannot_parse_exception'
require 'date'

#TODO: unit test this
#TODO: integration test this
class EmailOMatic

  def email_reminders_to(*recipients)
    begin
      reminders = ReminderLoader.load
      reminders.send_reminders(recipients)
    rescue CannotParseException => e
      send_exception_message_to(e, recipients)
    end
  end

  def send_exception_message_to(e, recipients)
    message = "Message:\n#{e.message}\n\nStacktrace:\n#{e.backtrace}\n"
    recipients.each do |recipient|
      EmailSender.new.send_email(message, recipient.email_address)
    end
  end
end