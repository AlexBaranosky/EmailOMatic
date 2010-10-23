require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

class Reminder
  attr_reader :message

  def initialize(message, calendar)
    @message, @calendar = message, calendar
  end

  def days_from_now_due?(num_days)
    next_time_to_remind and next_time_to_remind - DateTime.now < num_days
  end

  def next_time_to_remind
    @calendar.next_time
  end

  def ==(other)
    @message == other.message and @calendar == other.calendar
  end

  protected

  attr_reader :calendar
end

