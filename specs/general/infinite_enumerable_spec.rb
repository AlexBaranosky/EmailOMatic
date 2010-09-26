require "spec"
require File.dirname(__FILE__) + '/../../src/general/infinite_enumerable'

class InfiniteEnumerableForTest
  include InfiniteEnumerable

  def each
    count = 0
    loop { yield count; count += 1 }
  end
end

describe InfiniteEnumerable do
  #TODO: should be tests covering this infinite enumerable stuff.  Fix that.
  # it "should be able select without infinitely recurring" 
end