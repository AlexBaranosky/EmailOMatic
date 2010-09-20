require File.dirname(__FILE__) + '/reminder_timing_info_parser'
require File.dirname(__FILE__) + '/../../src/general/string_extensions'

class ReminderParser
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
    timing_info_string, reminder_message = line.chomp.split("\"")
    timing_info = @reminder_timing_info_parser.new(timing_info_string).parse(timing_info_string)
    Reminder.new(reminder_message, timing_info)
  end
end
