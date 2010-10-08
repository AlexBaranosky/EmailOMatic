require 'spec'
require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'
require File.dirname(__FILE__) + '/../../src/reminder/group_of_reminders'

NUM_REMINDERS_ALREADY_SENT_TODAY = 3
def today; DateTime.now.wday end
def yesterday; today == 0 ? 6 : today - 1 end

describe PersistentEmailRecords do

  it "should reset the number of reminders already sent to 0 on each new day" do
    given_records_last_updated(yesterday)
    @records.num_reminders_already_sent_today.should == 0
  end

  it 'should know the number of reminders already sent today' do
    given_records_last_updated(today)
    @records.num_reminders_already_sent_today.should == NUM_REMINDERS_ALREADY_SENT_TODAY
  end

  it "should record a reminders' count and day of persisting" do
    given_records_last_updated(yesterday)
    @records.record_num_of_reminders_and_todays_wday_value([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    @records.num_reminders_already_sent_today.should == 12
  end

  def given_records_last_updated(wday)
    @records = PersistentEmailRecords.new(fake_records_file(wday))
  end
end

def fake_records_file(wday)
  file_name = File.dirname(__FILE__) + '/../../resources/fake_persistent_email_records.txt'
  File.open(file_name, 'w') do |f|
    f.write("NUM_REMINDERS_SENT_ALREADY_TODAY: #{NUM_REMINDERS_ALREADY_SENT_TODAY}\nLAST_PERSIST_WDAY: #{wday}")
  end
  file_name
end