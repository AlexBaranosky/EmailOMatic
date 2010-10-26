require File.dirname(__FILE__) + '/calendar_parser'
require File.dirname(__FILE__) + '/../reminder/reminder'
require File.dirname(__FILE__) + '/../../src/extensions/string_extensions'

class ReminderParser
  def parse(line)
    reminder_line?(line) ? parse_reminder(line) : nil
  end

  private

  def reminder_line?(line)
    !line.comment? and !line.blank?
  end

  def parse_reminder(line)
    calendar_part, message_part, days_in_advance_to_notify = line.chomp.split("\"")
    calendar = CalendarParser.for(calendar_part).parse(calendar_part)
    if days_in_advance_to_notify
      days_in_advance_to_notify =~ /^\s*notify (\d+) days? in advance\s*$/
      Reminder.new(message_part, calendar, $1.to_i)
    else
      Reminder.new(message_part, calendar)
    end
  end
end
