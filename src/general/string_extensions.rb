module StringExtensions
  def blank?
    strip == ''
  end

  def comment?
    lstrip[0] == ?#
  end

  def matches?(regex)
    !match(regex).nil?  
  end
end

class String
  include StringExtensions
end