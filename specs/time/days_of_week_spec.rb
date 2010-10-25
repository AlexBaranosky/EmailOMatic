require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

add_equals_method :DaysOfWeek

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

  it 'should be an infinite enumeration of DateTimes for the specified days' do
    A_THURSDAY = Date.civil(2010, 9, 23)
    Timecop.freeze(A_THURSDAY) do
      day = DaysOfWeek.new(:wednesdays, :fridays)
      day.first.wday.should == FRIDAY_
      day.second.wday.should == WEDNESDAY_
    end
  end

  it "should not accept invalid days" do
    DaysOfWeek.new(:sundays)
    DaysOfWeek.new(:mondays)
    DaysOfWeek.new(:tuesdays)
    DaysOfWeek.new(:wednesdays)
    DaysOfWeek.new(:thursdays)
    DaysOfWeek.new(:fridays)
    DaysOfWeek.new(:saturdays)
    proc { DaysOfWeek.new(:gizundays) }.should raise_error
  end

  it 'should define each() and include LazyEnumerable' do
    day = DaysOfWeek.new(:wednesdays)
    day.kind_of?(LazyEnumerable).should == true

    defined? day.each.should == true
  end
end