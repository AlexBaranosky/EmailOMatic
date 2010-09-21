require 'spec'
require File.dirname(__FILE__) + '/../../src/reminder/reminder_timing_info'

describe ReminderTimingInfo do

  it 'should tell the next date time in the future' do
    timing_info = ReminderTimingInfo.new([DateTime.civil(3000, 1, 1), DateTime.civil(3000, 2, 1)])
    timing_info.next_time.should == DateTime.civil(3000, 1, 1)
  end

  it 'should tell the next date time in the future, when given two different sources of date times' # do
#    timing_info = ReminderTimingInfo.new([[DateTime.civil(3000, 2, 1), DateTime.civil(3000, 3, 1)], [DateTime.civil(3000, 1, 1)]], nil)
#    timing_info.next_time.should == DateTime.civil(3000, 1, 1)
#  end
end