require "rspec"
require 'timecop'
require File.dirname(__FILE__) + '/../../src/email/reminder_email_formatter'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/group_of_reminders'
require File.dirname(__FILE__) + '/../../src/time/timing_info'

describe ReminderEmailFormatter do
  formatter = ReminderEmailFormatter.new

  #TODO: seems to be a lot of dependencies needed for this test.  Look into that.
  it "should format reminders into a email message" do
    SATURDAY_SEP_25 = Date.civil(2010, 9, 25)
    Timecop.freeze(SATURDAY_SEP_25) do
      reminder1 = Reminder.new("message 1", TimingInfo.new(DaysOfWeek.new(:sundays)))
      reminder2 = Reminder.new("message 2", TimingInfo.new(DaysOfWeek.new(:mondays)))
      reminders = GroupOfReminders.new(reminder1, reminder2)

      formatter.format_due_reminders_for_email(reminders).should ==
              "The following reminders are coming up for tomorrow and the day after tomorrow: \n\n1. Sundays 9/26/2010\nmessage 1\n\n2. Mondays 9/27/2010\nmessage 2"
    end
  end
end