require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/extensions/lazy_enumerable'

class LazyEnumerableForTest
  include LazyEnumerable

  def each
    count = 0
    loop { yield count; count += 1 }
  end
end

describe LazyEnumerable do
  it "should be able select without infinitely recurring" do
    LazyEnumerableForTest.new.select {|x| x < 5}.first.should == 0
    LazyEnumerableForTest.new.select {|x| x < 5}.first.next.should == 1
    LazyEnumerableForTest.new.select {|x| x < 5}.first.next.next.should == 2
  end
end