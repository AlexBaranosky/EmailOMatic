require "rspec"
require 'timecop'
require File.dirname(__FILE__) + '/../../src/email/reminder_email_creator'
require File.dirname(__FILE__) + '/../../src/email/email_recipient'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'
require File.dirname(__FILE__) + '/../../src/time/calendar'

describe ReminderEmailCreator do
  email_maker = ReminderEmailCreator.new

  it "should format reminders into a email message" do
    SATURDAY_SEP_25 = Date.civil(2010, 9, 25)
    Timecop.freeze(SATURDAY_SEP_25) do
      recipient = EmailRecipient.new('JOHN', 'john@yahoo.com')

      reminder1 = Reminder.new("message 1", Calendar.new(DaysOfWeek.new(:sundays)))
      reminder2 = Reminder.new("message 2", Calendar.new(DaysOfWeek.new(:mondays)))

      #TODO: make this use splat
      email_maker.create_email(recipient, [reminder1, reminder2]).should ==
              "From:     \"EmailOMatic Reminder Service\" <>\nTo: \"    JOHN    \" <    john@yahoo.com    >\nSubject: EmailOMatic Reminder Service\nThe following reminders are coming up for tomorrow and the day after tomorrow: \n\n1. Sundays 9/26/2010\nmessage 1\n\n2. Mondays 9/27/2010\nmessage 2"
    end
  end
end