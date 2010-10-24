require File.dirname(__FILE__) + '/../src/reminder/reminder_loader'
require 'date'

class EmailOMatic
  def email_reminders_to(recipients)
    reminders = ReminderLoader.load
    recipients.each do |recipient|
      reminders.send_reminders(recipient)
    end
  end
end



