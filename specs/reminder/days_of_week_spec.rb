require 'spec'
require File.dirname(__FILE__) + '/../../src/reminder/days_of_week'

describe DaysOfWeek do
  WEDNESDAY_ = 3
  FRIDAY_ = 5

  it 'should be an infinite enumeration of DateTimes for the specified day' do
    day = DaysOfWeek.new(:wednesdays)
    day.first.wday.should == WEDNESDAY_
    day.second.wday.should == WEDNESDAY_
  end
                             
  it 'should return the day at midnight EST' do
    day = DaysOfWeek.new(:saturdays)
    first = day.first
    first.hour.should == 0
    first.sec.should == 0
  end

  # time sensitive......
  it 'should be an infinite enumeration of DateTimes for the specified two days' do
    day = DaysOfWeek.new(:wednesdays, :fridays)
    day.second.wday.should == FRIDAY_
    day.first.wday.should == WEDNESDAY_
  end

  it 'should consider equal any two DayOfWeeks created with same day specified' do
    day1 = DaysOfWeek.new(:wednesdays)
    day2 = DaysOfWeek.new(:wednesdays)
    day1.should == day2
  end

  it 'should consider not equal any two DayOfWeeks created with different days specified' do
    day1 = DaysOfWeek.new(:wednesdays)
    day2 = DaysOfWeek.new(:fridays)
    day1.should_not == day2
  end

  it 'should consider equal any two DayOfWeeks created with same daysss specified' do
    day1 = DaysOfWeek.new(:wednesdays, :fridays)
    day2 = DaysOfWeek.new(:fridays, :wednesdays)
    day1.should == day2
  end

  it 'should define each() and include InfiniteLazyEnumerable' do
    day = DaysOfWeek.new(:wednesdays)
    day.kind_of?(InfiniteEnumerable).should == true

    defined? day.each.should == true
  end
end