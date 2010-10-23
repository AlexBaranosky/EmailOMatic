require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

module LazyEnumerable
  include Enumerable

  def select(&block)
    lazily_enumerate(:select) { |enum, value| enum.yield(value) if block.call(value) }
  end

  def map(&block)
    lazily_enumerate(:map) { |enum, value| enum.yield(block.call(value)) }
  end

  def collect(&block);
    map(&block)
  end

  def each(&block)
    lazily_enumerate(:each) { |enum, value| enum.yield value }
  end

end

