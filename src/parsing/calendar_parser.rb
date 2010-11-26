require 'active_support'
require File.dirname(__FILE__) + '/../../src/extensions/date_extensions'
require File.dirname(__FILE__) + '/../../src/extensions/string_extensions'
require File.dirname(__FILE__) + '/../../src/time/calendar'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/time/days_of_month'
require File.dirname(__FILE__) + '/../../src/time/every_x_weeks'

module CalendarParser
  ORDINALS = (1..31).map { |n| ActiveSupport::Inflector::ordinalize n }

  def self.for(string)
    [DayOfWeekBased, DayOfMonthBased, DateBased, EveryXWeeksBased, EveryDayBased].each do |parser|
      return parser.new if parser.can_parse? string
    end
    raise 'Cannot create calendar parser. String has invalid format.'
  end

  class MultiTokenedCalendarParser
    def parse(string)
      tokens         = string.split('&')
      reminder_times = parse_tokens(tokens)
      Calendar.new(reminder_times)
    end
  end

  class DayOfWeekBased < MultiTokenedCalendarParser

    DAYS_OF_WEEK_REGEX = /^\s*(#{Date::DAYS_OF_WEEK.join('|')})/i

    def self.can_parse?(s); s.matches? DAYS_OF_WEEK_REGEX end

    def parse_tokens(tokens)
      def parse_token(token)
        token =~ DAYS_OF_WEEK_REGEX
        $1.downcase.to_sym
      end

      day_syms = tokens.map { |t| parse_token t }
      DaysOfWeek.new(*day_syms)
    end
  end

  class DayOfMonthBased < MultiTokenedCalendarParser

    def self.can_parse?(s)
      s.matches?(/^\s*Every /i) and s.matches?(/ of the month\s*$/i)
    end

    def parse_tokens(tokens)
      def parse_token(token)
        ordinals = token.scan(/#{ORDINALS.join('|')}/i)
        ordinals.map(&:to_i)
      end

      mdays = tokens.map { |t| parse_token t }.flatten
      DaysOfMonth.new(*mdays)
    end
  end

  class DateBased < MultiTokenedCalendarParser

    DATE_REGEX = /^\s*(\d{4})\s+(\d{1,2})\s+(\d{1,2})/

    def self.can_parse?(s); s.matches?(DATE_REGEX) end

    def parse_tokens(tokens)
      def parse_token(token)
        token =~ DATE_REGEX
        year, month, day = [$1, $2, $3].map(&:to_i)
        DateTime.civil(year, month, day)
      end

      tokens.map { |t| parse_token t }
    end
  end

  class EveryDayBased

    REGEX = /^\s*Every ?day/i

    def self.can_parse?(s); s.matches? REGEX end

    def parse(s)
      everyday = DaysOfWeek.new(:sundays, :mondays, :tuesdays, :wednesdays, :thursdays, :fridays, :saturdays)
      Calendar.new(everyday)
    end
  end

  class EveryXWeeksBased

    REGEX = /^\s*Every\s+(#{ORDINALS.join('|')})\s+(#{Date::DAYNAMES.join('|')}),?\s+starting\s+(\d{1,2})\/(\d{1,2})\/(\d{4}).*/i

    def self.can_parse?(s); s.matches? REGEX end

    def parse(s)
      s =~ REGEX
      day_sym = $2.downcase.to_sym
      frequency, month, day, year = [$1, $3, $4, $5].map(&:to_i)
      nwd = EveryXWeeks.new(day_sym, DateTime.civil(year, month, day), frequency)
      Calendar.new(nwd)
    end
  end
end