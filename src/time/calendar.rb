class Calendar

  def initialize(date_times)
    @date_times = date_times
  end

  def next_date_time
    @date_times.find { |time| time - DateTime.now > 0 }
  end

  def ==(other)
    @date_times == other.date_times
  end

  protected
  
  attr_reader :date_times
end