require File.dirname(__FILE__) + '/../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../src/email/emailer'
require File.dirname(__FILE__) + '/../src/reminder/emailable_reminders'
require 'date'

class EmailOMatic
  def email_reminders_to(recipients)
    reminders = ReminderLoader.load
    reminders.send_due_reminders(recipients)
  end
end

class ReminderLoader
  REMINDERS_FILE = File.dirname(__FILE__) + '/../resources/reminders.txt'

  def self.load
    raise('the file with the reminders in it was not found') unless File.exists?(REMINDERS_FILE)

    File.open(REMINDERS_FILE).each_with_object(EmailableReminders.new) do |line, reminders|
      reminder = ReminderParser.new.parse(line)
      reminders << reminder if (reminder)
    end
  end
end



