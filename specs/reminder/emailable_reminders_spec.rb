require 'rspec'
require 'rr'
require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

#TODO: <PRIORITY HIGH 2> update this test to test expected API of new code
describe EmailableReminders do

  RR::new_instance_of(EmailHistory) do |history|
    RR::mock(history).save_num_reminders_sent_and_todays_wday
    RR::mock(history).num_reminders_already_sent_today { 0 }
  end

  #FAILING
  it 'should send any reminders that are due to the recipient' do
    reminders = EmailableReminders.new(stub_reminder(true), stub_reminder(false) )
    reminders.due_reminders.size.should == 1
  end
end

def stub_reminder(due)
  RR::stub!.days_from_now_due? { due }.subject
end
