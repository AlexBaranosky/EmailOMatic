require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/timing_info_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

describe DayOfWeekBasedTimingInfoParser do
  parser = DayOfWeekBasedTimingInfoParser.new

  it 'should parse timing infos out of a day of week based string' do
    parser.parse('  Sundays  ').should == TimingInfo.new(DaysOfWeek.new(:sundays))
  end

  it 'should parse multiple timing infos out of a day of week based string' do
    parser.parse(' Mondays & Tuesdays ').should == TimingInfo.new(DaysOfWeek.new(:mondays, :tuesdays))
  end
end