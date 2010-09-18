require File.dirname(__FILE__) + '/../../src/general/infinite_enumerable'

module TimeCycle
  include InfiniteEnumerable

  def self.included(clazz)
    clazz.class_eval do
      def ==(other)
        other.kind_of? self.class and @valid_time_points.to_set == other.valid_time_points.to_set
      end
    end
  end

  def initialize(time_points)
    raise "invalid time point" if time_points.size == 0 || any_invalid_time_points?(time_points)
    @valid_time_points = time_points
  end

  def each
    point = go_to_first_of_specified_time_points

    loop do
      yield point
      point = advance_to_midnight_of_next_specified_time_point(point)
    end
  end

  protected

  attr_reader :valid_time_points

  private

  def go_to_first_of_specified_time_points
    date = DateTime.now
    date += 1 until specified_time_point?(date)
    DateTime.civil(date.year, date.month, date.day, 0, 0, 0)
  end

  def advance_to_midnight_of_next_specified_time_point(starting_from)
    date = starting_from
    begin
      date += 1
    end until specified_time_point?(date)
    date
  end
end