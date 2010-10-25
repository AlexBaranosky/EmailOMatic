require 'rspec'
require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/reminder/emailable_reminders'

NUM_REMINDERS_ALREADY_SENT_TODAY = 3
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

  def given_history_last_saved(wday)
    @history = EmailHistory.new
    @history.instance_variable_set(:@history_file, fake_history_file(wday))
  end
end

def fake_history_file(wday)
  file_name = File.dirname(__FILE__) + '/../../resources/fake_persistent_email_records.txt'
  File.open(file_name, 'w') do |f|
    f.write("NUM_REMINDERS_SENT_ALREADY_TODAY: #{NUM_REMINDERS_ALREADY_SENT_TODAY}\nLAST_PERSIST_WDAY: #{wday}")
  end
  file_name
end