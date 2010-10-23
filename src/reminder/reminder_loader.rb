require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

class ReminderLoader
  DEFAULT_REMINDER_FILE = File.dirname(__FILE__) + '/../resources/reminders.txt'

  def self.load(reminder_file = DEFAULT_REMINDER_FILE)
    raise('the file with the reminders in it was not found') unless File.exists?(reminder_file)

    File.open(reminder_file).each_with_object(EmailableReminders.new) do |line, reminders|
      reminder = ReminderParser.new.parse(line)
      reminders << reminder if (reminder)
    end
  end
end