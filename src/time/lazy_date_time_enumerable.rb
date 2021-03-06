require 'date'
require 'set'
require File.dirname(__FILE__) + '/../../src/extensions/lazy_enumerable'

module LazyDateTimeEnumerable
  include LazyEnumerable

  def initialize(*dates)
    raise "invalid date input: '#{dates}'" unless dates.size > 0 && valid?(dates)
    @dates = dates
  end

  def each
    date = first_date_in_cycle

    loop do
      yield date
      date = midnight_of_next_date_in_cycle_after(date)
    end
  end

  private

  def first_date_in_cycle
    date = DateTime.now
    next_date_in_cycle_after(date)
  end

  def midnight_of_next_date_in_cycle_after(date)
    date += 1
    next_date_in_cycle_after(date)
  end

  def next_date_in_cycle_after(date)
    date += 1 until date_in_the_cycle?(date)
    DateTime.civil(date.year, date.month, date.day, 23, 59, 59)
  end
end