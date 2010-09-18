require "spec"
require File.dirname(__FILE__) + '/../../src/reminder/days_of_month'

describe DaysOfMonth do
  it "should be an infinite enumeration of DateTimes for the specified day of the month" do
    day = DaysOfMonth.new([1])
    day.first.day.should == 1
    day.second.day.should == 1
  end

  it "should consider equal any two DayOfMonths created with same day specified" do
    day1 = DaysOfMonth.new([2])
    day2 = DaysOfMonth.new([2])
    day1.should == day2
  end

  it "should consider not equal any two DayOfMonths created with different days specified" do
    day1 = DaysOfMonth.new([5])
    day2 = DaysOfMonth.new([10])
    day1.should_not == day2
  end

  it "should define 'each' and include InfiniteLazyEnumerable" do
    day = DaysOfMonth.new([9])
    day.kind_of?(InfiniteEnumerable).should == true

    defined? day.each.should == true
  end

  it "should not go infinite recursion on me" do
    day = DaysOfMonth.new([11])
    day.first
  end
end