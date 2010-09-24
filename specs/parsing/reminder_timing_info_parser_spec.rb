require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'

describe ReminderTimingInfoParser do

  it 'should create a date based timing info parser' do
    should_create_proper_parser(' 1 2 2000 ', DateBasedTimingInfoParser)
  end

  it 'should create a day of week based timing info parser' do
    should_create_proper_parser(' Sundays ', DayOfWeekBasedTimingInfoParser)
  end

  it 'should create a day of month based timing info parser' do
    should_create_proper_parser(' Every 6 of the month ', DayOfMonthBasedTimingInfoParser)
  end
  
  it 'should raise error if bad string' do
    proc { ReminderTimingInfoParser.new(" SCREWED UP LINE OF UNPARSEABLE STUFF ") }.should raise_error
  end

  def should_create_proper_parser(string, parser_type)
     ReminderTimingInfoParser.new(string).instance_of?(parser_type).should == true
  end
end