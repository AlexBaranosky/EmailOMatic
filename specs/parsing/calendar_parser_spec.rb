require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'

describe CalendarParser do

  it 'should create a date based calendar parser' do
    should_create_proper_parser(' 2000 1 2  & 2000 1 2   ', CalendarParser::DateBased)
  end

  it 'should create a day of week based calendar parser' do
    should_create_proper_parser(' Sundays & Saturdays', CalendarParser::DayOfWeekBased)
  end

  it 'should create a day of month based calendar parser' do
    should_create_proper_parser(' Every 6th of the month  & Every 8th of the month', CalendarParser::DayOfMonthBased)
  end

  it 'should create an every day based calendar parser' do
    should_create_proper_parser(' Every day ', CalendarParser::EveryDayBased)
  end

  it 'should create an n weekly days based calendar parser' do
    should_create_proper_parser(' Every 2nd Thursday starting 12/6/2010  ', CalendarParser::EveryXWeeksBased)
  end

  it 'should raise error if bad string' do
    proc { CalendarParser.for(" SCREWED UP LINE OF UNPARSEABLE STUFF ") }.should raise_error
  end

  def should_create_proper_parser(string, parser_type)
    CalendarParser.for(string).instance_of?(parser_type).should == true
  end
end