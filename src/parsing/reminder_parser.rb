require File.dirname(__FILE__) + '/calendar_parser'
require File.dirname(__FILE__) + '/../reminder/reminder'
require File.dirname(__FILE__) + '/../../src/extensions/string_extensions'
require File.dirname(__FILE__) + '/../../src/parsing/cannot_parse_exception'

class ReminderParser
  def parse(line)
    reminder_line?(line) ? parse_reminder(line) : nil
  end

  private

  def reminder_line?(line)
    !line.comment? and !line.blank?
  end

  def parse_reminder(line)
    calendar_part, message_part, days_in_advance_to_notify_part = line.chomp.split("\"")
    calendar = CalendarParser.for(calendar_part).parse(calendar_part)
    days_in_advance = DaysInAdvanceParser.parse(days_in_advance_to_notify_part)

    Reminder.new(message_part, calendar, days_in_advance)
  end
end

class DaysInAdvanceParser
  DEFAULT_DAYS_IN_ADVANCE_TO_NOTIFY = 3

  def self.parse(s)
    return DEFAULT_DAYS_IN_ADVANCE_TO_NOTIFY unless s

    s =~ /^\s*notify (\d+) days? in advance\s*$/
    raise CannotParseException.new "invalidly formed 'days in advance to notify' string: #{s}" unless $1
    $1.to_i
  end
end
