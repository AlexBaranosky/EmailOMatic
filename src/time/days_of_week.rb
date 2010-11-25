require File.dirname(__FILE__) + '/../../src/extensions/lazy_enumerable'
require File.dirname(__FILE__) + '/lazy_date_time_enumerable'
require 'set'

class DaysOfWeek
  include LazyDateTimeEnumerable

  WEEKDAYS         = {:sundays => 0, :mondays => 1, :tuesdays => 2, :wednesdays => 3, :thursdays => 4, :fridays => 5, :saturdays => 6,
                      :sunday  => 0, :monday => 1, :tuesday => 2, :wednesday => 3, :thursday => 4, :friday => 5, :saturday => 6}
  WEEKDAYS.default = nil

  def self.weekdays
    WEEKDAYS
  end

  private

  def valid?(day_syms)
    day_syms.none? { |d| WEEKDAYS[d].nil? }
  end

  def date_in_the_cycle?(date)
    @dates.map { |d| WEEKDAYS[d] }.include?(date.wday)
  end
end