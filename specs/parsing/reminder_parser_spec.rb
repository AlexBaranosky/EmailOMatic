require "spec"
require "rr"
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/reminder/days_of_week'

class FakeReminderTimingInfoParser < ReminderTimingInfoParser
  def self.new(* args)
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
  include TimingInfoParser

  def parse_tokens(tokens); DaysOfWeek.new(:sundays) end
end