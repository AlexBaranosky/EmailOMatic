require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

class EveryXWeeks
  include Enumerable

  def initialize(day_sym, start_date, every_nth_week)
    raise "invalid date input: '#{day_sym}'" unless DaysOfWeek.weekdays.keys.include?(day_sym)
    @date           = DaysOfWeek.weekdays[day_sym]
    raise "start date must match the given day symbol" unless @date == start_date.wday
    @every_nth_week = every_nth_week
    @start_date     = start_date
  end

  def each
    date = @start_date

    loop do
      yield date
      date = next_date_at_midnight(date)
    end
  end

  def next_date_at_midnight(date)
    d = date + 7 * @every_nth_week
    DateTime.civil(d.year, d.month, d.day, 0, 0, 0)
  end
end