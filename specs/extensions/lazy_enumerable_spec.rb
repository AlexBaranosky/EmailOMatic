require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/extensions/lazy_enumerable'

class ConcreteLazyEnumerable
  include LazyEnumerable

  def each
    count = 0
    loop { yield count; count += 1 }
  end
end

describe LazyEnumerable do
  it "should be able select without infinitely recurring" do
    ConcreteLazyEnumerable.new.select {|x| x < 5}.first.should == 0
    ConcreteLazyEnumerable.new.select {|x| x < 5}.first.next.should == 1
    ConcreteLazyEnumerable.new.select {|x| x < 5}.first.next.next.should == 2
  end
end