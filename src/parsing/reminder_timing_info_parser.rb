require File.dirname(__FILE__) + '/../../src/general/date_extensions'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'
require File.dirname(__FILE__) + '/../../src/reminder/timing_info'

class ReminderTimingInfoParser

  def self.new(s)
    if (day_of_week_based? s)
      DayOfWeekBasedTimingInfoParser.new
    elsif (day_of_month_based? s)
      DayOfMonthBasedTimingInfoParser.new
    elsif (date_based? s)
      DateBasedTimingInfoParser.new
    else
      raise 'Invalid and unexpected state of the reminder data file, when parsing the raw reminder time data'
    end
  end

  private

  def self.day_of_week_based?(s)
    Date::DAYS_OF_WEEK.any? { |day| s.include? day }
  end

  def self.day_of_month_based?(s)
    s =~ /^\s*Every \d{1,2} of the month/i #TODO, same regex as below in the DayOfMonthBased...Parser
  end

  def self.date_based?(s)
    s =~ /^\s*\d{4}\s+\d{1,2}\s+\d{1,2}\s*/
  end
end

module TimingInfoParser
  def parse(timing_info_string)
    tokens = timing_info_string.split('&')
    reminder_times = parse_tokens(tokens)
    TimingInfo.new(reminder_times)
  end
end

class DayOfWeekBasedTimingInfoParser
  include TimingInfoParser

  def parse_tokens(tokens)
    def parse_token(token)
      token =~ /\s*(Sundays|Mondays|Tuesdays|Wednesdays|Thursdays|Fridays|Saturdays)\s*/i
      $1.downcase.to_sym
    end

    day_syms = tokens.map { |t| parse_token t }
    DaysOfWeek.new(* day_syms)
  end
end

class DayOfMonthBasedTimingInfoParser
  include TimingInfoParser

  def parse_tokens(tokens)
    def parse_token(token)
      token =~ /^\s*Every (\d{1,2}) of the month/i
      $1.to_i
    end

    mdays = tokens.map { |t| parse_token t }
    DaysOfMonth.new(* mdays)
  end
end

class DateBasedTimingInfoParser
  include TimingInfoParser

  def parse_tokens(tokens)
    def parse_token(token)
      year, month, day = token.split(' ').map { |part| part.to_i }
      DateTime.civil(year, month, day)
    end

    tokens.map { |t| parse_token t }
  end
end