require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/time/every_x_weeks'

describe CalendarParser::EveryXWeeksBased do
  parser = CalendarParser::EveryXWeeksBased.new

  it 'should parse properly formatted strings' do
    CalendarParser::EveryXWeeksBased.can_parse?('Sunday').should == false
    CalendarParser::EveryXWeeksBased.can_parse?('Every 2nd Sunday, starting 12/6/2010').should == true
  end

  it 'should parse calendars out of a day of week based string' do
    parser.parse('Every 2nd Sunday, starting 12/6/2010').should == Calendar.new(EveryXWeeks.new(:sundays, DateTime.civil(2010, 12, 6), 2))
  end

  before(:all) { add_equals_method :Calendar, :EveryXWeeks }
  after(:all) { remove_equals_method :Calendar, :EveryXWeeks }
end