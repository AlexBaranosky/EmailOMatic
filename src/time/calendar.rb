class Calendar
  def initialize(date_times)
    @date_times = date_times
  end

  def next_date_time
    @date_times.find { |time| time - DateTime.now > 0 }
  end
end