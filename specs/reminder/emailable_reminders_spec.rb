require 'rspec'
require 'rr'
require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

describe EmailableReminders do

  reminders = EmailableReminders.new

  RR::new_instance_of(PersistentEmailRecords) do |records|
    RR::mock(records).record_num_of_reminders_and_todays_wday_value
    RR::mock(records).num_reminders_already_sent_today { 0 }
  end

  it "should persist reminder's size and day" do
    reminders.send(:persist_due_reminder_count_and_day)
    #TODO: this spec appears to not be complete! fix that!
  end

  it 'should know if it is ready to be sent' do
    reminders.send(:ready_to_be_sent?).should == false
    reminders << stub_reminder
    reminders.send(:ready_to_be_sent?).should == true
  end

  it 'should return the reminders for the next two days when asked for the reminders which are ready to be sent' do
    reminders = EmailableReminders.new(stub_reminder, stub_reminder)
    reminders.send(:reminders_ready_to_be_sent).size.should == 2
  end
end

def stub_reminder
  RR::stub!.days_from_now_due? { true }.subject
end
