require File.dirname(__FILE__) + '/../../src/general/infinite_enumerable'
require File.dirname(__FILE__) + '/../../src/reminder/time_cycle'
require 'set'

class DaysOfWeek
  include TimeCycle

  private

  WDAYS = { :sundays => 0, :mondays => 1, :tuesdays => 2, :wednesdays => 3, :thursdays => 4, :fridays => 5, :saturdays => 6 }
  WDAYS.default = nil

  def specified_time_point?(date)
    valid_time_points.map { |d| WDAYS[d] }.include?(date.wday)
  end

  def any_invalid_time_points?(day_syms)
    day_syms.any? { |d| WDAYS[d] == nil }
  end
end