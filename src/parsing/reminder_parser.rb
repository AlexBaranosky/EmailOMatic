require File.dirname(__FILE__) + '/timing_info_parser'
require File.dirname(__FILE__) + '/../reminder/reminder'
require File.dirname(__FILE__) + '/../../src/general/string_extensions'

class ReminderParser
  def initialize(reminder_timing_info_parser = TimingInfoParser)
    @reminder_timing_info_parser = reminder_timing_info_parser
  end

  def parse(line)
    reminder_line?(line) ? parse_reminder(line) : nil
  end

  private

  def reminder_line?(line)
    !line.comment? and !line.blank?
  end

  def parse_reminder(line)
    timing_info_string, reminder_message = line.chomp.split("\"")
    timing_info = @reminder_timing_info_parser.new(timing_info_string).parse(timing_info_string)
    Reminder.new(reminder_message, timing_info)
  end
end
