require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/time/n_weekly_days'

describe CalendarParser::MultiWeeklyBased do
  parser = CalendarParser::MultiWeeklyBased.new

  it 'should parse properly formatted strings' do
    CalendarParser::MultiWeeklyBased.can_parse?('Sunday').should == false
    CalendarParser::MultiWeeklyBased.can_parse?('Every 2nd Sunday, starting 12/6/2010').should == true
  end

  it 'should parse calendars out of a day of week based string' do
    parser.parse('Every 2nd Sunday, starting 12/6/2010').should == Calendar.new(NWeeklyDays.new(:sundays, DateTime.civil(2010, 12, 6), 2))
  end

  before(:all) { add_equals_method :Calendar, :NWeeklyDays }
  after(:all) { remove_equals_method :Calendar, :NWeeklyDays }
end