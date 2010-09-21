require File.dirname(__FILE__) + '/../../src/general/date_extensions'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'
require File.dirname(__FILE__) + '/../../src/reminder/timing_info'

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

  def self.day_of_week_based?(sections)
    def self.contains_any_day(string)
      Date::DAYS_OF_WEEK.any? { |day| string.include?(day) }
    end

    sections.any? { |section| contains_any_day(section) }    
  end

  def self.day_of_month_based?(sections)
    sections.include?('Every')
  end

  def self.date_based?(sections)
    !day_of_week_based?(sections) && !day_of_month_based?(sections)
  end
end

module TimingInfoParser
  def parse(timing_info_string)
    tokens = timing_info_string.split('&')
    reminder_times = parse_sections(tokens)
    TimingInfo.new(reminder_times)
  end
end

class DayOfWeekBasedTimingInfoParser
  include TimingInfoParser

  def parse_sections(sections)
    def parse_section(section)
      section =~ /\s*(Sundays|Mondays|Tuesdays|Wednesdays|Thursdays|Fridays|Saturdays)\s*/i
      $1.downcase.to_sym
    end

    day_syms = sections.map { |s| parse_section s }
    DaysOfWeek.new(day_syms)
  end
end

class DayOfMonthBasedTimingInfoParser
  include TimingInfoParser

  def parse_sections(sections)
    def parse_section(section)
      section =~ /\s*Every\s+(\d+)\s+of\s+the\s+month\s*/i
      $1.to_i
    end
    mdays = sections.map { |s| parse_section s }
    DaysOfMonth.new(mdays)
  end
end

class DateBasedTimingInfoParser
  include TimingInfoParser

  def parse_sections(sections)
    def parse_section(section)
      year, month, day = section.split(' ').map { |part| part.to_i }
      DateTime.civil(year, month, day)
    end

    sections.map { |s| parse_section s }
  end
end