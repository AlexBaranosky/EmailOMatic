require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_month'

describe CalendarParser::DayOfMonthBased do

  parser = CalendarParser::DayOfMonthBased.new

  it 'can parse properly formatted strings' do
    CalendarParser::DayOfMonthBased.can_parse?('Every 21st of the month').should == true
    CalendarParser::DayOfMonthBased.can_parse?('Every 21st and 28th of the month').should == true
    CalendarParser::DayOfMonthBased.can_parse?('Every 21st, 22nd and 28th of the month').should == true
  end

  it 'should parse calendars from ordinal numbers' do
    parser.parse('Every 15th of the month').should == Calendar.new(DaysOfMonth.new(15))
    parser.parse('Every 1st of the month').should == Calendar.new(DaysOfMonth.new(1))
    parser.parse('Every 2nd of the month').should == Calendar.new(DaysOfMonth.new(2))
    parser.parse('Every 3rd of the month').should == Calendar.new(DaysOfMonth.new(3))
    parser.parse('Every 21st of the month').should == Calendar.new(DaysOfMonth.new(21))
    parser.parse('Every 22nd of the month').should == Calendar.new(DaysOfMonth.new(22))
    parser.parse('Every 23rd of the month').should == Calendar.new(DaysOfMonth.new(23))
    parser.parse('Every 31st of the month').should == Calendar.new(DaysOfMonth.new(31))
  end

  it 'should fail to parse calendars from improper ordinal numbers' do
    proc { parser.parse('Every 15st of the month') }.should raise_error
    proc { parser.parse('Every 15nd of the month') }.should raise_error
    proc { parser.parse('Every 15rd of the month') }.should raise_error
  end

  it 'should parse multiple calendars out of a day of week based string' do
    parser.parse(' Every 15th of the month & Every 22nd of the month ').should == Calendar.new(DaysOfMonth.new(15, 22))
  end

  it 'should ignore case when parsing calendars' do
    parser.parse('EvERy 15TH of THE month').should == Calendar.new(DaysOfMonth.new(15))
  end

  it 'should parse 2 days of the month at once' do
    parser.parse('Every 21st and 28th of the month').should == Calendar.new(DaysOfMonth.new(21, 28))
  end

  it 'should parse multiple days of the month at once' do
    parser.parse('Every 21st, 22nd and 28th of the month').should == Calendar.new(DaysOfMonth.new(21, 22, 28))
  end

  before(:all) { add_equals_method :Calendar, :DaysOfMonth }
  after(:all) { remove_equals_method :Calendar, :DaysOfMonth }
end