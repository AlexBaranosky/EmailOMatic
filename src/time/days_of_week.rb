require File.dirname(__FILE__) + '/../../src/extensions/lazy_enumerable'
require File.dirname(__FILE__) + '/lazy_date_time_enumerable'
require 'set'

class DaysOfWeek
  include LazyDateTimeEnumerable

  private

  WDAYS = { :sundays => 0, :mondays => 1, :tuesdays => 2, :wednesdays => 3, :thursdays => 4, :fridays => 5, :saturdays => 6 }
  WDAYS.default = nil

  def valid?(day_syms)
    day_syms.none? { |d| WDAYS[d].nil? }
  end

  def date_in_the_cycle?(date)
    @dates.map { |d| WDAYS[d] }.include?(date.wday)
  end
end