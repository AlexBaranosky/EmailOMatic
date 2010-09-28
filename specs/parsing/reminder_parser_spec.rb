require "spec"
require File.dirname(__FILE__) + '/../../src/parsing/timing_info_parser'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'

class FakeReminderTimingInfoParser < TimingInfoParser
  def self.new(*args)
    ReminderTimingInfoParserForTest.new
  end
end

describe ReminderParser do
  parser = ReminderParser.new(FakeReminderTimingInfoParser)

  it "should ignore comments" do
    parser.parse(' # a comment here').should == nil
  end

  it "should parse line into a Reminder" do
    parser.parse("irrelevant-part-of-string\"message\"").should == Reminder.new('message', TimingInfo.new(DaysOfWeek.new(:sundays)))
  end
end

class ReminderTimingInfoParserForTest
  include ParsesTimingInfo

  def parse_tokens(tokens); DaysOfWeek.new(:sundays) end
end