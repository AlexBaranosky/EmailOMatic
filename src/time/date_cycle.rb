require 'date'
require 'set'
require File.dirname(__FILE__) + '/../../src/general/infinite_enumerable'

module DateCycle
  include InfiniteEnumerable

  def ==(other)
    other.kind_of? self.class and @dates.to_set == other.dates.to_set
  end

  def initialize(* dates)
    raise 'invalid date' unless dates.size > 0 && valid?(dates)
    @dates = dates
  end

  def each
    date = go_to_first_date_in_cycle

    loop do
      yield date
      date = advance_to_midnight_of_next_date_in_cycle(date)
    end
  end

  protected

  attr_reader :dates

  private

  def go_to_first_date_in_cycle
    date = DateTime.now
    date += 1 until date_in_the_cycle?(date)
    DateTime.civil(date.year, date.month, date.day, 0, 0, 0)
  end

  def advance_to_midnight_of_next_date_in_cycle(starting_from)
    date = starting_from
    begin
      date += 1
    end until date_in_the_cycle?(date)
    date
  end
end