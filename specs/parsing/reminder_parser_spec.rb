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
    parser.parse("irrelevant-part-of-string\"message\" notify 33 days in advance").should == Reminder.new('message', Calendar.new(DaysOfWeek.new(:sundays)), 33)
  end

  it "should parse line with only one day in advance into a Reminder" do
    parser.parse("irrelevant-part-of-string\"message\" notify 1 day in advance").should == Reminder.new('message', Calendar.new(DaysOfWeek.new(:sundays)), 1)
  end

  it 'parses lines with no notify X days in advance to the default notification range' do
    parser.parse("irrelevant-part-of-string\"message\"").should == Reminder.new('message', Calendar.new(DaysOfWeek.new(:sundays)), 3)
  end

  before(:all) { add_equals_method :Calendar, :Reminder, :DaysOfWeek }
  after(:all) { remove_equals_method :Calendar, :Reminder, :DaysOfWeek }
end

class CalendarParserForTest < CalendarParser::MultiTokenedCalendarParser
  def parse_tokens(tokens); DaysOfWeek.new(:sundays) end
end