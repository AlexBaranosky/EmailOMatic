require File.dirname(__FILE__) + '/../extensions/lazy_enumerable'
require File.dirname(__FILE__) + '/lazy_date_time_enumerable'
require 'set'

class DaysOfMonth
  include LazyDateTimeEnumerable

  private

  def valid?(day_nums)
    day_nums.all? { |d| (1..31).include? d }
  end

  def date_in_the_cycle?(date)
    @dates.any? { |d| d == date.day }
  end
end