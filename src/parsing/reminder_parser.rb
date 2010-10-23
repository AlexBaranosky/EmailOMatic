require File.dirname(__FILE__) + '/timing_info_parser'
require File.dirname(__FILE__) + '/../reminder/reminder'
require File.dirname(__FILE__) + '/../../src/general/string_extensions'

class ReminderParser
  def parse(line)
    reminder_line?(line) ? parse_reminder(line) : nil
  end

  private

  def reminder_line?(line)
    !line.comment? and !line.blank?
  end

  def parse_reminder(line)
    timing_info_part, message_part = line.chomp.split("\"")
    timing_info = CalendarParser.for(timing_info_part).parse(timing_info_part)
    Reminder.new(message_part, timing_info)
  end
end
