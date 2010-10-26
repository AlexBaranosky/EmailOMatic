require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

describe ReminderParser do
  parser = ReminderParser.new
  before(:each) { stub(CalendarParser).for { CalendarParserForTest.new } }

  it "should ignore comments" do
    parser.parse(' # a comment here').should == nil
  end

  it "should parse line into a Reminder" do
    parser.parse("irrelevant-part-of-string\"message\"").should == Reminder.new('message', Calendar.new(DaysOfWeek.new(:sundays)))
  end

  before(:all) { add_equals_method :Calendar, :Reminder, :DaysOfWeek }
  after(:all) { remove_equals_method :Calendar, :Reminder, :DaysOfWeek }
end

class CalendarParserForTest < CalendarParser::Base
  def parse_tokens(tokens); DaysOfWeek.new(:sundays) end
end