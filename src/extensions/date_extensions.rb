require 'date'

module DateExtensions
  DAYS_OF_WEEK = %w[Sundays Mondays Tuesdays Wednesdays Thursdays Fridays Saturdays ]

  def m_d_y
    [mon, mday, year].join('/')
  end

  def as_day
    DAYS_OF_WEEK[wday]
  end
end

class Date
  include DateExtensions
end                                   