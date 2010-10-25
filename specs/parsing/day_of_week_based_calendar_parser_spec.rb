require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

add_equals_method :Calendar, :DaysOfWeek

describe CalendarParser::DayOfWeekBased do
  parser = CalendarParser::DayOfWeekBased.new

  it 'should parse properly formatted strings' do
    CalendarParser::DayOfWeekBased.can_parse?('Sundays').should == true
  end

  it 'should parse calendars out of a day of week based string' do
    parser.parse('  Sundays  ').should == Calendar.new(DaysOfWeek.new(:sundays))
  end

  it 'should parse multiple calendars out of a day of week based string' do
    parser.parse(' Mondays & Tuesdays ').should == Calendar.new(DaysOfWeek.new(:mondays, :tuesdays))
  end
end