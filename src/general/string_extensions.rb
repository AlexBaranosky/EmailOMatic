module StringExtensions
  def blank?
    strip == ''
  end

  def comment?
    lstrip[0] == ?#
  end
end

class String
  include StringExtensions
end