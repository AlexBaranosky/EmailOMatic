require "spec"
require "timecop"
require File.dirname(__FILE__) + '/../../src/time/days_of_month'

describe DaysOfMonth do
  it "should be an infinite enumeration of DateTimes for the specified day of the month" do
    days = DaysOfMonth.new(1)
    days.first.day.should == 1
    days.second.day.should == 1
  end

  it "should consider equal any two DayOfMonths created with same day specified" do
    days1 = DaysOfMonth.new(2)
    days2 = DaysOfMonth.new(2)
    days1.should == days2
  end

  it "should be able to create it with more than one day" do
    Timecop.freeze(Date.civil(2000, 1, 1)) do
      days = DaysOfMonth.new(10, 15)
      days.first.mday.should == 10
      days.second.mday.should == 15
    end
  end

  it "should consider not equal any two DayOfMonths created with different days specified" do
    days1 = DaysOfMonth.new(5)
    days2 = DaysOfMonth.new(10)
    days1.should_not == days2
  end

  it "should not accept invalid days" do
    proc { DaysOfMonth.new(0) }.should raise_error
    DaysOfMonth.new(1)
    DaysOfMonth.new(31)
    proc { DaysOfMonth.new(32) }.should raise_error
  end

  it "should define 'each' and include InfiniteEnumerable" do
    days = DaysOfMonth.new(1)
    days.kind_of?(InfiniteEnumerable).should == true

    defined? days.each.should == true
  end
end