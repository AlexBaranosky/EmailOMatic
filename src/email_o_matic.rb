require File.dirname(__FILE__) + '/../src/reminder/reminder_loader'
require 'date'

#TODO: unit test this
#TODO: integration test this
class EmailOMatic
  def email_reminders_to(*recipients)
    reminders = ReminderLoader.load
    reminders.send_reminders(recipients)
  end
end



