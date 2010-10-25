require 'rspec'
require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

NUM_REMINDERS_ALREADY_SENT_TODAY = 99
def today; DateTime.now.wday end
def yesterday; today == 0 ? 6 : today - 1 end

describe EmailHistory do

  it "should reset the number of reminders already sent to 0 on each new day" do
    given_history_last_saved(yesterday)
    @history.num_reminders_already_sent_today.should == 0
  end

  it 'should know the number of reminders already sent today' do
    given_history_last_saved(today)
    @history.num_reminders_already_sent_today.should == NUM_REMINDERS_ALREADY_SENT_TODAY
  end

  it "should history a reminders' count and day of persisting" do
    given_history_last_saved(yesterday)
    @history.save_num_reminders_sent_and_todays_wday(12)
    @history.num_reminders_already_sent_today.should == 12
  end

  def given_history_last_saved(weekday)
    EmailHistory.const_set(:HISTORY_FILE, fake_history_file(weekday))
    @history = EmailHistory.new
  end
end

def fake_history_file(weekday)
  file_name    = File.dirname(__FILE__) + '/../../resources/fake_email_history.yaml'
  fake_history = {'num reminders already sent today' => NUM_REMINDERS_ALREADY_SENT_TODAY,
                  'weekday last saved on'            => weekday}
  File.open(file_name, 'w') { |f| f.write fake_history.to_yaml }
  file_name
end