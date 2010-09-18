require 'spec'
require 'rr'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/reminder_timing_info'

FRIDAY_APRIL_2 = DateTime.parse("2010/4/2")
SATURDAY_APRIL_3 = DateTime.parse("2010/4/3")
DAYS_IN_THE_FUTURE = 1000

describe Reminder do
  MESSAGE_ = 'some message'

  it "should give next time to remind for date-based reminders" do
    future_timing_info = stub_timing_info(DateTime.now + DAYS_IN_THE_FUTURE)
    reminder = Reminder.new(MESSAGE_, future_timing_info)
    reminder.next_time_to_remind.should_not be_nil
  end

  it "should give next time to remind for day of the week based reminders" do
    fridays = stub_timing_info(DaysOfWeek.new([:fridays]).first)
    reminder = Reminder.new(MESSAGE_, fridays)

    next_time = reminder.next_time_to_remind

    next_time.wday.should == 5
  end

  it "should say if the next time to remind is within x days" do
    future_timing_info = stub_timing_info(DateTime.now + DAYS_IN_THE_FUTURE)
    reminder = Reminder.new(MESSAGE_, future_timing_info)
    reminder.days_from_now_due?(DAYS_IN_THE_FUTURE).should == true
  end
end

def stub_timing_info(time)
  timing_info = ReminderTimingInfo.new(nil, nil)
  RR::stub(timing_info).next_time { time }
  timing_info
end