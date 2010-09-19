require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'
require File.dirname(__FILE__) + '/../../src/reminder/days_of_week'

describe DayOfWeekBasedTimingInfoParser do
  parser = DayOfWeekBasedTimingInfoParser.new

  it 'should parse timing infos out of a day of week based string' do
    parser.parse('  Sundays  ').should == ReminderTimingInfo.new(DaysOfWeek.new([:sundays]), [1])
  end

  it 'should parse multiple timing infos out of a day of week based string' do
    parser.parse(' Mondays & Tuesdays ').should == ReminderTimingInfo.new(DaysOfWeek.new([:mondays, :tuesdays]), [1, 1])
  end
end