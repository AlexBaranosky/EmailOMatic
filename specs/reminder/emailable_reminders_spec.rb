require 'rspec'
require 'rr'
require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

#TODO: update this test to test expected API of new code
describe EmailableReminders do

  RR::new_instance_of(PersistentEmailRecords) do |records|
    RR::mock(records).record_num_of_reminders_and_todays_wday_value
    RR::mock(records).num_reminders_already_sent_today { 0 }
  end

  it 'should send any reminders that are due to the recipient' do
    reminders = EmailableReminders.new(stub_reminder(true), stub_reminder(false) )
    reminders.due_reminders.size.should == 1
  end
end

def stub_reminder(due)
  RR::stub!.days_from_now_due? { due }.subject
end
