require 'date'
require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/time/every_x_weeks'

describe EveryXWeeks do
  it 'should be able to cycle every 2nd' do
    A_TUESDAY = Date.civil(2010, 9, 7)
    Timecop.freeze(A_TUESDAY) do
      days = EveryXWeeks.new(:wednesdays, Date.civil(2010, 9, 8), 2)
      days.first.should == Date.civil(2010, 9, 8)
      days.second.should == Date.civil(2010, 9, 22)
    end
  end

  it 'should be able to cycle every 3rd (or 4th .... infinite)' do
    A_TUESDAY = Date.civil(2010, 9, 7)
    Timecop.freeze(A_TUESDAY) do
      days = EveryXWeeks.new(:wednesdays, Date.civil(2010, 9, 8), 3)
      days.first.should == Date.civil(2010, 9, 8)
      days.second.should == Date.civil(2010, 9, 29)
    end
  end

  it 'should return the day at midnight EST' do
    day   = EveryXWeeks.new(:wednesdays, Date.civil(2010, 9, 8), 1)
    first = day.first
    first.send(:hour).should == 0
    first.send(:sec).should == 0
  end
end