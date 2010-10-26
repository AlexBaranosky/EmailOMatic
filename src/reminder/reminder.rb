require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

class Reminder
  attr_reader :message

  def initialize(message, calendar, days_in_advance_to_notify = 5)
    @message, @calendar, @days_in_advance_to_notify = message, calendar, days_in_advance_to_notify
  end

  def due?
    return false unless next_date_time
    DateTime.now >= next_date_time - @days_in_advance_to_notify
  end

  def next_date_time
    @calendar.next_date_time
  end

  def to_s
    date = next_date_time
    "#{date.as_day} #{date.m_d_y}\n#{message}"
  end
end

