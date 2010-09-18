require "spec"
require "rr"
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'
require File.dirname(__FILE__) + '/../../src/reminder/days_of_week'

class MockReminderTimingInfoParser < ReminderTimingInfoParser
  def self.new(* args)
    ReminderTimingInfoParserForTest.new
  end
end

describe ReminderParser do
  parser = ReminderParser.new(MockReminderTimingInfoParser)

  it "should ignore comments" do
    parser.parse(' # a comment here').should == nil
  end

  it "should parse line into a Reminder" do
    parser.parse("irrelevant-part-of-string\"message\"").should == Reminder.new('message', ReminderTimingInfo.new([DaysOfWeek.new([:sundays])], [1]))
  end
end

class ReminderTimingInfoParserForTest
  include TimingInfoParser

  def parse_section(section); [DaysOfWeek.new([:sundays]), 1] end

  def reminder_times_converter(times); times end
end