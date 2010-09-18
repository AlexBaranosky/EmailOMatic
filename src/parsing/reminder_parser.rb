require File.expand_path(File.dirname(__FILE__) + '/reminder_timing_info_parser.rb')
require File.dirname(__FILE__) + '/../../src/general/string_extensions'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'
require File.dirname(__FILE__) + '/../../src/general/date_extensions'
require File.dirname(__FILE__) + '/../../src/reminder/reminder'
require File.dirname(__FILE__) + '/../../src/reminder/reminder_timing_info'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'
require 'date'

class ReminderParser
  REMINDER_MESSAGE_DEMARCATOR = "\""

  def initialize(reminder_timing_info_parser = ReminderTimingInfoParser)
    @reminder_timing_info_parser = reminder_timing_info_parser
  end

  def parse(line)
    return nil unless reminder_line?(line)
    parse_reminder_from_line(line)
  end

  private

  def reminder_line?(line)
    !line.comment? and !line.blank?
  end

  def parse_reminder_from_line(line)
    timing_info_string, reminder_message = line.chomp.split(REMINDER_MESSAGE_DEMARCATOR)
    timing_info = @reminder_timing_info_parser.new(timing_info_string).parse(timing_info_string)
    Reminder.new(reminder_message, timing_info)
  end
end
