require File.dirname(__FILE__) + '/../general/lazy_enumerable'
require File.dirname(__FILE__) + '/date_cycle'
require 'set'

class DaysOfMonth
  include DateCycle

  private

  def valid?(day_nums)
    day_nums.all? { |d| d <= 31 && d >= 1 }
  end

  def date_in_the_cycle?(date)
    @dates.any? { |d| d == date.day }
  end
end