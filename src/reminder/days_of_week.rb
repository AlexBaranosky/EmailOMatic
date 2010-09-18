require File.dirname(__FILE__) + '/../../src/general/infinite_enumerable'
require File.dirname(__FILE__) + '/../../src/reminder/time_cycle'
require 'set'

class DaysOfWeek
  include TimeCycle

  private

  def specified_time_point?(date)
    valid_time_points.map { |d| day_of_week(d) }.include?(date.wday)
  end

  def any_invalid_time_points?(day_syms)
    day_syms.any? { |d| day_of_week(d) == nil }
  end

  def day_of_week(sym)
    wday = { :sundays => 0, :mondays => 1, :tuesdays => 2, :wednesdays => 3, :thursdays => 4, :fridays => 5, :saturdays => 6 }
    wday.default = nil
    wday[sym]
  end
end