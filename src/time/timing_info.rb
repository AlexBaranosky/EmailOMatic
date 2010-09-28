class TimingInfo

  def initialize(date_times)
    @date_times = date_times
  end

  def next_time
    @date_times.select { |time| time - DateTime.now > 0 }.first
  end

  def ==(other)
    @date_times == other.date_times
  end

  protected
  
  attr_reader :date_times
end