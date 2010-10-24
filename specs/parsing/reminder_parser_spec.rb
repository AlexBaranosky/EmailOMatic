require "rspec"
require "rr"
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

#RSpec.configure do |config|
#  config.mock_with :rr
#end

describe ReminderParser do

  parser = ReminderParser.new
  RR::stub(CalendarParser).for { ReminderTimingInfoParserForTest.new }

  it "should ignore comments" do
    parser.parse(' # a comment here').should == nil
  end

  it "should parse line into a Reminder" do
    parser.parse("irrelevant-part-of-string\"message\"").should == Reminder.new('message', Calendar.new(DaysOfWeek.new(:sundays)))
  end
end

class ReminderTimingInfoParserForTest < CalendarParser::Base
  def parse_tokens(tokens); DaysOfWeek.new(:sundays) end
end