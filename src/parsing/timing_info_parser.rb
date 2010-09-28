require File.dirname(__FILE__) + '/../../src/general/date_extensions'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'
require File.dirname(__FILE__) + '/../../src/time/timing_info'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/time/days_of_month'

class TimingInfoParser

  def self.new(s)
    parsers = [DayOfWeekBasedTimingInfoParser, DayOfMonthBasedTimingInfoParser, DateBasedTimingInfoParser]
    parsers.each { |p| return p.new if p.can_parse? s }
    raise 'Cannot parse reminders.  Invalid format.'
  end
end

module ParsesTimingInfo
  def parse(timing_info_string)
    tokens = timing_info_string.split('&')
    reminder_times = parse_tokens(tokens)
    TimingInfo.new(reminder_times)
  end
end

class DayOfWeekBasedTimingInfoParser
  include ParsesTimingInfo

  def self.can_parse?(s)
    Date::DAYS_OF_WEEK.any? { |day| s.include? day }
  end

  def parse_tokens(tokens)
    def parse_token(token)
      token =~ /\s*(Sundays|Mondays|Tuesdays|Wednesdays|Thursdays|Fridays|Saturdays)\s*/i
      $1.downcase.to_sym
    end

    day_syms = tokens.map { |t| parse_token t }
    DaysOfWeek.new(*day_syms)
  end
end

class DayOfMonthBasedTimingInfoParser
  include ParsesTimingInfo
  
  DAY_OF_MONTH_REGEX = /^\s*Every (\d{1,2}) of the month/i

  def self.can_parse?(s); s =~ DAY_OF_MONTH_REGEX end

  def parse_tokens(tokens)
    def parse_token(token)
      token =~ DAY_OF_MONTH_REGEX
      $1.to_i
    end

    mdays = tokens.map { |t| parse_token t }
    DaysOfMonth.new(*mdays)
  end
end

class DateBasedTimingInfoParser
  include ParsesTimingInfo

  def self.can_parse?(s); s =~ /^\s*\d{4}\s+\d{1,2}\s+\d{1,2}\s*/ end

  def parse_tokens(tokens)
    def parse_token(token)
      year, month, day = token.split(' ').map(&:to_i)
      DateTime.civil(year, month, day)
    end

    tokens.map { |t| parse_token t }
  end
end