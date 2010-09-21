require 'spec'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'
require File.dirname(__FILE__) + '/../../src/general/enumerable_extensions'

describe Enumerable do

  class EnumerableForTesting
    include Enumerable

    def initialize(array)
      @arr = array
    end

    def each
      dup = @arr.dup
      yield dup[0]
      @array = @array[2..-1]
    end

  end

  it "should be able to access the first element" do
    ['a'].first.should == 'a'
  end

  it "should be able to access the second element" do
    ['a', 'b'].second.should == 'b'
  end
end