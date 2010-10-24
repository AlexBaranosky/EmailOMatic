require "rspec"
require File.dirname(__FILE__) + '/../../src/extensions/lazy_enumerable'

class InfiniteEnumerableForTest
  include LazyEnumerable

  def each
    count = 0
    loop { yield count; count += 1 }
  end
end

describe LazyEnumerable do
  #TODO: should be tests covering this infinite enumerable stuff.  Fix that.
  it "should be able select without infinitely recurring"
end