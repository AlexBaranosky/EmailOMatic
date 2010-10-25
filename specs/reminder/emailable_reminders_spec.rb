require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

#TODO: <PRIORITY HIGH 2> update this test to test expected API of new code
describe EmailableReminders do

  # see below, commented out code: mocking with new_instance_of seems to not be getting torn down after a test

#  before(:each) do
#    new_instance_of(EmailHistory) do |history|
#      mock(history).save_num_reminders_sent_and_todays_wday
#      mock(history).num_reminders_already_sent_today { 0 }
#    end
#  end

  #FAILING
  it 'should send any reminders that are due to the recipient'
#  do
#    reminders = EmailableReminders.new(stub_reminder(true), stub_reminder(false))
#    reminders.due_reminders.size.should == 1
#  end
end

def stub_reminder(due)
  stub!.days_from_now_due? { due }.subject
end
