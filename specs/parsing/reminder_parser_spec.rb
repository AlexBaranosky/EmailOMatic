require "rspec"
require "rr"
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/extensions/kernel_extensions'

Calendar = subclass_with_equals :Calendar
Reminder = subclass_with_equals :Reminder

#TODO: use something like the below to make RR stubbing go away after this test is over; so to not pollute the rest of the tests
#RSpec.configure do |config|
#  config.mock_with :rr
#end

describe ReminderParser do

  parser = ReminderParser.new
  RR::stub(CalendarParser).for { CalendarParserForTest.new }

  it "should ignore comments" do
    parser.parse(' # a comment here').should == nil
  end

  it "should parse line into a Reminder" do
    parser.parse("irrelevant-part-of-string\"message\"").should == Reminder.new('message', Calendar.new(DaysOfWeek.new(:sundays)))
  end
end

class CalendarParserForTest < CalendarParser::Base
  def parse_tokens(tokens)
    ; DaysOfWeek.new(:sundays)
  end
end