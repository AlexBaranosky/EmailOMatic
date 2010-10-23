require File.dirname(__FILE__) + '/../src/reminder/reminder_loader'
require 'date'

class EmailOMatic
  def email_reminders_to(recipients)
    reminders = ReminderLoader.new.load
    reminders.send_due_reminders(recipients)
  end
end



