require 'spec'
require 'rr'
require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/group_of_reminders'

describe GroupOfReminders do
  reminders = nil

  before(:each) { reminders = GroupOfReminders.new([], stub_email_records) }

  it "should persist reminder's size and day" do
    reminders.persist_due_reminder_count_and_day
    #TODO: this spec appears to not be complete! fix that!
  end

  it 'should know if it is ready to be sent' do
    reminders.ready_to_be_sent?.should == false
    reminders << stub_reminder
    reminders.ready_to_be_sent?.should == true
  end

  it 'should return the reminders for the next two days when asked for the reminders which are ready to be sent' do
    reminders << stub_reminder << stub_reminder
    reminders.reminders_ready_to_be_sent.size.should == 2
  end
end

def stub_email_records
  email_records = RR::stub!.record_num_of_reminders_and_todays_wday_value.with_any_args.subject
  RR::stub(email_records).num_reminders_already_sent_today { 0 }.subject
end

def stub_reminder
  RR::stub!.days_from_now_due?.with_any_args { true }.subject
end
