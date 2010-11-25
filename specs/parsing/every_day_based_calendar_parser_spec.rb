require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

describe CalendarParser::EveryDayBased do
  parser = CalendarParser::EveryDayBased.new

  it 'should parse properly formatted strings' do
    CalendarParser::EveryDayBased.can_parse?('Sundays').should == false
    CalendarParser::EveryDayBased.can_parse?('   Every day  ').should == true
    CalendarParser::EveryDayBased.can_parse?('   Everyday  ').should == true
  end

  it 'should parse strings, ignoring case' do
    CalendarParser::EveryDayBased.can_parse?('   EVERY day  ').should == true
    CalendarParser::EveryDayBased.can_parse?('   EveryDAY  ').should == true
  end

  it 'should parse calendars out of a every day based string' do
    parser.parse('  Every day  ').should == Calendar.new(
        DaysOfWeek.new(:sundays, :mondays, :tuesdays, :wednesdays, :thursdays, :fridays, :saturdays))
  end

  before(:all) { add_equals_method :DaysOfWeek, :Calendar }
  after(:all) { remove_equals_method :DaysOfWeek,  :Calendar }
end