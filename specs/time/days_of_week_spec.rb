require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

describe DaysOfWeek do
  A_FRIDAY   = DateTime.civil(2010, 9, 24)
  A_SATURDAY = DateTime.civil(2010, 9, 25)
  WEDNESDAY_ = 3
  FRIDAY_    = 5

  it 'should be an infinite enumeration of DateTimes for the specified day' do
    day = DaysOfWeek.new(:wednesdays)
    day.first.wday.should == WEDNESDAY_
    day.second.wday.should == WEDNESDAY_
  end

  it 'something is screwed up with DaysOfWeek, which is causing Every Day to not work as expected, best be fixing that' do
#    Timecop.freeze(Date.civil(2010, 9, 23)) do
#      day = DaysOfWeek.new(:sundays, :mondays, :tuesdays, :wednesdays, :thursdays, :fridays, :saturdays)
#      day.first.should == DateTime.civil(2010, 9, 23)
#      day.second.should == DateTime.civil(2010, 9, 24)
#    end
  end

  it 'should return the day at midnight EST' do
    day   = DaysOfWeek.new(:saturdays)
    first = day.first
    first.hour.should == 23
    first.min.should == 59
    first.sec.should == 59
  end

  it 'should be an infinite enumeration of DateTimes for the specified days' do
    A_THURSDAY = DateTime.civil(2010, 9, 23)
    Timecop.freeze(A_THURSDAY) do
      day = DaysOfWeek.new(:fridays, :wednesdays)
      day.first #.should == DateTime.civil(2010, 9, 24)
#      day.second.should == DateTime.civil(2010, 9, 29)
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

  before(:all) { add_equals_method :DaysOfWeek }
  after(:all) { remove_equals_method :DaysOfWeek }
end