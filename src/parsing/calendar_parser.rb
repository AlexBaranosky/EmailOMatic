require 'active_support'
require File.dirname(__FILE__) + '/../../src/extensions/date_extensions'
require File.dirname(__FILE__) + '/../../src/extensions/string_extensions'
require File.dirname(__FILE__) + '/../../src/time/calendar'
require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/time/days_of_month'

module CalendarParser
  def self.for(string)
    [DayOfWeekBased, DayOfMonthBased, DateBased].each { |parser| return parser.new if parser.can_parse? string }
    raise 'Cannot create calendar parser. String has invalid format.'
  end

  class Base
    def parse(string)
      tokens         = string.split('&')
      reminder_times = parse_tokens(tokens)
      Calendar.new(reminder_times)
    end
  end

  class DayOfWeekBased < Base

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

  class DayOfMonthBased < Base

    ORDINALS = (1..31).map { |n| ActiveSupport::Inflector::ordinalize n }

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

  class DateBased < Base

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

  class EveryDayBased < Base

    REGEX = /^\s*Every ?day/i

    def self.can_parse?(s); s.matches?(REGEX) end

    def parse_tokens(tokens)
      DaysOfWeek.new(:sundays, :mondays, :tuesdays, :wednesdays, :thursdays, :fridays, :saturdays)
    end
  end
end