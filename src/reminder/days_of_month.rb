require File.dirname(__FILE__) + '/../general/infinite_enumerable'
require File.dirname(__FILE__) + '/../reminder/time_cycle'
require 'set'

class DaysOfMonth
  include TimeCycle

  private

  def specified_time_point?(date)
    valid_time_points.any? { |d| d == date.day }
  end

  def any_invalid_time_points?(day_nums)
    day_nums.any? { |d| d > 31 || d < 1 }
  end
end