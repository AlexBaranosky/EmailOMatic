require 'enumerator'

module EnumerableExtensions
  def first
    each { |x| return x }
  end

  def second
    each_with_index { |x, idx| return x if idx == 1 }
  end

  protected

  def lazily_enumerate(sym, &block)
    return enum_for(sym) unless block_given?
    enum_for(:each) do |enum|
      self.each do |value|
        block.call(enum, value)
      end
    end
  end
end

module Enumerable
  def first
    each { |x| return x }
  end

  def second
    each_with_index { |x, idx| return x if idx == 1 }
  end

  protected

  def lazily_enumerate(sym, &block)
    return enum_for(sym) unless block_given?
    enum_for(:each) do |enum|
      self.each do |value|
        block.call(enum, value)
      end
    end
  end
end

