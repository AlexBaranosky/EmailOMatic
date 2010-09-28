require File.dirname(__FILE__) + '/../../src/general/infinite_enumerable'
require File.dirname(__FILE__) + '/date_cycle'
require 'set'

class DaysOfWeek
  include DateCycle

  private

  WDAYS = { :sundays => 0, :mondays => 1, :tuesdays => 2, :wednesdays => 3, :thursdays => 4, :fridays => 5, :saturdays => 6 }
  WDAYS.default = nil

  def valid?(day_syms)
    day_syms.all? { |d| WDAYS[d] != nil }
  end

  def date_in_the_cycle?(date)
    @dates.map { |d| WDAYS[d] }.include?(date.wday)
  end
end