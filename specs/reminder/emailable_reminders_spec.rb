require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/time/calendar'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

#TODO:  update this test to test expected API of new code
describe EmailableReminders do
  before(:each) do
    new_instance_of(EmailHistory) do |history|
      mock(history).save_num_reminders_sent_and_todays_wday
      mock(history).num_reminders_already_sent_today { 0 }
    end
  end

#  it 'should send any reminders that are due to the recipient' do
#    new_instance_of(ReminderEmailCreator) { |creator| dont_allow(creator).create_email }
#    reminders = EmailableReminders.new(stub_reminder(true))
##    reminders.send_reminders(nil)
#  end

end

def stub_reminder(due)
  stub!.due? { due }.subject
end
