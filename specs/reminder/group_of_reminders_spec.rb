require 'spec'
require 'rr'
require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/group_of_reminders'

describe GroupOfReminders do
  reminders = nil

  before(:each) { reminders = GroupOfReminders.new([], mock_email_records) }

  it "should persist reminder's size and day" do
    reminders.persist_due_reminder_count_and_day
    #TODO: this spec appears to not be complete! fix that!
  end

  it 'should know if it is ready to be sent' do
    reminders.ready_to_be_sent?.should == false
    reminders << mock_reminder
    reminders.ready_to_be_sent?.should == true
  end

  it 'should return the reminders for the next two days when asked for the reminders which are ready to be sent' do
    reminders << mock_reminder << mock_reminder
    reminders.reminders_ready_to_be_sent.size.should == 2
  end
end

def mock_email_records
  email_records = PersistentEmailRecords.new
  RR::mock(email_records).persist_due_reminder_count_and_day.with_any_args
  RR::stub(email_records).num_reminders_already_sent_today { 0 }
  email_records
end

def mock_reminder
  reminder = Reminder.new(nil, nil)
  RR::stub(reminder).days_from_now_due?.with_any_args { true }
  reminder
end
