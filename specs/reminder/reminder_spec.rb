require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/time/calendar'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

FRIDAY_APRIL_2 = DateTime.parse("2010/4/2")
SATURDAY_APRIL_3 = DateTime.parse("2010/4/3")
DAYS_IN_THE_FUTURE = 1000

describe Reminder do
  MESSAGE_ = 'some message'

  it "should give next time to remind for date-based reminders" do
    future_calendar = stub_calendar(DateTime.now + DAYS_IN_THE_FUTURE)
    reminder = Reminder.new(MESSAGE_, future_calendar)
    reminder.next_date_time.should_not be_nil
  end

  it "should give next time to remind for day of the week based reminders" do
    fridays = stub_calendar(DaysOfWeek.new(:fridays).first)
    reminder = Reminder.new(MESSAGE_, fridays)

    next_date = reminder.next_date_time

    next_date.wday.should == 5
  end

  it 'is due when we are within X days of the next date to remind' do
    Timecop.freeze(Date.civil(2000, 1, 1)) do
      calendar  = stub_calendar(Date.civil(2000, 1, 3))
      reminder1 = Reminder.new(MESSAGE_, calendar, 1)
      reminder1.due?.should == false
      reminder2 = Reminder.new(MESSAGE_, calendar, 2)
      reminder2.due?.should == true
    end
  end
end

def stub_calendar(date_time)
  stub!.next_date_time { date_time }.subject
end