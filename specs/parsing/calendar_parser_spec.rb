require 'rspec'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'

describe CalendarParser do

  it 'should create a date based calendar parser' do
    should_create_proper_parser(' 2000 1 2  & 2000 1 2   ', CalendarParser::DateBasedCalendarParser)
  end

  it 'should create a day of week based calendar parser' do
    should_create_proper_parser(' Sundays & Saturdays', CalendarParser::DayOfWeekBasedCalendarParser)
  end

  it 'should create a day of month based calendar parser' do
    should_create_proper_parser(' Every 6th of the month  & Every 8th of the month', DayOfMonthBasedCalendarParser)
  end

  it 'should raise error if bad string' do
    proc { CalendarParser.for(" SCREWED UP LINE OF UNPARSEABLE STUFF ") }.should raise_error
  end

  def should_create_proper_parser(string, parser_type)
    CalendarParser.for(string).instance_of?(parser_type).should == true
  end
end