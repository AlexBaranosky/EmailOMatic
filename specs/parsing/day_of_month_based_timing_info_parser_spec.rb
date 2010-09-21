require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'
require File.dirname(__FILE__) + '/../../src/reminder/days_of_month'

describe DayOfMonthBasedTimingInfoParser do
  parser = DayOfMonthBasedTimingInfoParser.new

  it 'should parse timing infos out of a day of week based string' do
    parser.parse('Every 15 of the month').should == TimingInfo.new(DaysOfMonth.new(15))
  end

  it 'should parse multiple timing infos out of a day of week based string' do
    parser.parse(' Every 15 of the month & Every 22 of the month ').should == TimingInfo.new(DaysOfMonth.new(15, 22))
  end
end