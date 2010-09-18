module ArrayExtensions
  def unzip
    [map { |x| x[0] }, map { |x| x[1] }]
  end
end

class Array
  include ArrayExtensions
end