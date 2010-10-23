require 'rspec'
require File.dirname(__FILE__) + '/../../src/parsing/timing_info_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

describe DayOfWeekBasedCalendarParser do
  parser = DayOfWeekBasedCalendarParser.new

  it 'should parse properly formatted strings' do
    DayOfWeekBasedCalendarParser.can_parse?('Sundays').should == true
  end

  it 'should parse timing infos out of a day of week based string' do
    parser.parse('  Sundays  ').should == Calendar.new(DaysOfWeek.new(:sundays))
  end

  it 'should parse multiple timing infos out of a day of week based string' do
    parser.parse(' Mondays & Tuesdays ').should == Calendar.new(DaysOfWeek.new(:mondays, :tuesdays))
  end
end