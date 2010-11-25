require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

describe DaysOfWeek do
  WEDNESDAY_ = 3
  FRIDAY_    = 5

  it 'should be an infinite enumeration of DateTimes for the specified day' do
    day = DaysOfWeek.new(:wednesdays)
    day.first.wday.should == WEDNESDAY_
    day.second.wday.should == WEDNESDAY_
  end

  it 'should return the day at midnight EST' do
    day   = DaysOfWeek.new(:saturdays)
    first = day.first
    first.hour.should == 0
    first.sec.should == 0
  end

  it 'should be an infinite enumeration of DateTimes for the specified days' do
    A_TUESDAY = Date.civil(2010, 9, 23)
    Timecop.freeze(A_TUESDAY) do
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

  it 'should be able to cycle every 2nd' do
    A_TUESDAY = Date.civil(2010, 9, 7)
    Timecop.freeze(A_TUESDAY) do
      days = NWeeklyDays.new(:wednesdays, Date.civil(2010, 9, 8), 2)
      days.first.should == Date.civil(2010, 9, 8)
      days.second.should == Date.civil(2010, 9, 22)
    end
  end

  it 'should be able to cycle every 3rd (or 4th .... infinite)' do
    A_TUESDAY = Date.civil(2010, 9, 7)
    Timecop.freeze(A_TUESDAY) do
      days = NWeeklyDays.new(:wednesdays, Date.civil(2010, 9, 8), 3)
      days.first.should == Date.civil(2010, 9, 8)
      days.second.should == Date.civil(2010, 9, 29)
    end
  end

  it 'should return the day at midnight EST' do
    day   = NWeeklyDays.new(:wednesdays, Date.civil(2010, 9, 8), 1)
    first = day.first
    first.send(:hour).should == 0
    first.send(:sec).should == 0
  end

  before(:all) { add_equals_method :DaysOfWeek }
  after(:all) { remove_equals_method :DaysOfWeek }
end