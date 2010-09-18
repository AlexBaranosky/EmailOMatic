require File.dirname(__FILE__) + '/../../src/general/date_extensions'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'
require File.dirname(__FILE__) + '/../../src/reminder/reminder_timing_info'

class ReminderTimingInfoParser

  def self.new(sections)
    if (day_of_week_based?(sections))
      DayOfWeekBasedTimingInfoParser.new
    elsif (day_of_month_based?(sections))
      DayOfMonthBasedTimingInfoParser.new
    elsif (date_based?(sections))
      DateBasedTimingInfoParser.new
    else
      raise 'Invalid and unexpected state of the reminder data file, when parsing the raw reminder time data'
    end
  end

  private

  def self.date_based?(sections)
    !day_of_week_based?(sections) && !day_of_month_based?(sections)
  end

  def self.day_of_week_based?(sections)
    def self.contains_any_day(string)
      Date::DAYS_OF_WEEK.any? { |day| string.include?(day) }
    end

    sections.any? { |section| contains_any_day(section) }    
  end

  def self.day_of_month_based?(sections)
    sections.include?('Every')
  end
end

module TimingInfoParser
  REMINDER_TIMING_INFO_SECTION_DELIMITER = '&'

  def parse(timing_info_string)
    sections = timing_info_string.split(REMINDER_TIMING_INFO_SECTION_DELIMITER)
    reminder_times, frequencies = sections.map { |it| parse_section(it) }.unzip
    ReminderTimingInfo.new(reminder_times_converter(reminder_times), frequencies)
  end
end

class DayOfWeekBasedTimingInfoParser
  include TimingInfoParser

  DAYS_OF_WEEK_REGEX = /\s*(Sundays|Mondays|Tuesdays|Wednesdays|Thursdays|Fridays|Saturdays)\s+(\d)*\s*/i

  def parse_section(section)
    section =~ DAYS_OF_WEEK_REGEX
    frequency = $2.nil? ? 1 : $2.to_i
    [$1.downcase.to_sym, frequency]
  end

  def reminder_times_converter(times); DaysOfWeek.new(times) end
end

class DayOfMonthBasedTimingInfoParser
  include TimingInfoParser

  MONTH_REGEX = /\s*Every\s+(\d+)\s+of\s+the\s+month\s*/i

  def parse_section(section)
    section =~ MONTH_REGEX
    frequency = 1
    [$1.to_i, frequency]
  end

  def reminder_times_converter(times); DaysOfMonth.new(times) end
end

class DateBasedTimingInfoParser
  include TimingInfoParser

  def parse_section(section)
    year, month, day = section.split(' ').map { |it| it.to_i }
    [DateTime.civil(year, month, day), 1]
  end

  def reminder_times_converter(times); times end
end
