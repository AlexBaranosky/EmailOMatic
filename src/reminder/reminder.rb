require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

class Reminder
  attr_reader :message

  def initialize(message, calendar)
    @message, @calendar = message, calendar
  end

  def days_from_now_due?(num_days)
    next_date_time and next_date_time - DateTime.now < num_days
  end

  def next_date_time
    @calendar.next_date_time
  end

  def ==(other)
    @message == other.message and @calendar == other.calendar
  end

  def to_s
    reminder_date = next_date_time
    "#{reminder_date.as_day} #{reminder_date.m_d_y}\n#{message}"
  end

  protected

  attr_reader :calendar
end

