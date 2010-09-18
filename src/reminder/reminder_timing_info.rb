class ReminderTimingInfo

  def initialize(date_times, frequencies)
    @date_times, @frequencies = date_times, frequencies
  end

  def next_time
    @date_times.select { |time| time - DateTime.now > 0 }.first
  end

  def ==(other)
    @date_times == other.date_times and @frequencies == other.frequencies
  end

  protected
  
  attr_reader :date_times, :frequencies
end