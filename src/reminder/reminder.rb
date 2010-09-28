require File.dirname(__FILE__) + '/../../src/time/days_of_week'
require File.dirname(__FILE__) + '/../../src/general/enumerable_monkey_patch'

class Reminder
  attr_reader :message

  def initialize(message, timing_info)
    @message, @timing_info = message, timing_info
  end

  def days_from_now_due?(num_days)
    next_time_to_remind and next_time_to_remind - DateTime.now < num_days
  end

  def next_time_to_remind
    @timing_info.next_time
  end

  def ==(other)
    @message == other.message and @timing_info == other.timing_info
  end

  protected

  attr_reader :timing_info
end

