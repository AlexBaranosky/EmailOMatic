require File.dirname(__FILE__) + '/../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../src/email/emailer'
require File.dirname(__FILE__) + '/../src/reminder/group_of_reminders'
require 'date'

class EmailOMatic
  REMINDERS_FILE = File.dirname(__FILE__) + '/../resources/reminders.txt'

  def initialize(emailer = Emailer.new, parser = ReminderParser.new)
    @emailer, @parser = emailer, parser
  end

  def email_reminders_to(recipients)
    reminders = read_reminders_from_reminders_file

    if(reminders.ready_to_be_sent?)
      @emailer.send_email(reminders, recipients)
      reminders.persist_due_reminder_count_and_day
    end
  end  

  private

  def read_reminders_from_reminders_file
    raise('the file with the reminders in it was not found') unless File.exists?(REMINDERS_FILE)

    reminders = GroupOfReminders.new
    File.open(REMINDERS_FILE).each do |line|
      reminder = @parser.parse(line)
      reminders << reminder if(reminder)
    end
    reminders
  end
end



