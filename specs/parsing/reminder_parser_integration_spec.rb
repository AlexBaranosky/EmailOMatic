require File.dirname(__FILE__) + '/../test_helpers'
require 'date'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_parser'

add_equals_method :Calendar, :Reminder, :DaysOfWeek

describe ReminderParser do

  MESSAGE     = "watch out for the new street cleaning towing!"
  TIME_A      = DateTime.parse("2010/4/1")
  TIME_B      = DateTime.parse("2010/5/1")

  DATE_STRING = "2010/4/1"
  DAY_STRING  = "Mondays"

  parser      = ReminderParser.new

  it 'should parse a date-based line into a proper Reminder object' do
    actual_reminder   = parser.parse(%Q|2010 4 1 "#{MESSAGE}"|)
    expected_reminder = Reminder.new(MESSAGE, Calendar.new([TIME_A]))
    actual_reminder.should == expected_reminder
  end

  it 'should parse a line with multiple date-based reminder times into a Reminder with multiple times' do
    actual_reminder   = parser.parse(%Q|2010 4 1 & 2010 5 1 "#{MESSAGE}"|)
    expected_reminder = Reminder.new(MESSAGE, Calendar.new([TIME_A, TIME_B]))
    actual_reminder.should == expected_reminder
  end

  it 'should parse a day-of-week-based line into a proper Reminder object' do
    actual_reminder   = parser.parse(%Q|Thursdays "#{MESSAGE}"|)
    expected_reminder = Reminder.new(MESSAGE, Calendar.new(DaysOfWeek.new(:thursdays)))
    actual_reminder.should == expected_reminder
  end
end