require 'spec'
require File.dirname(__FILE__) + '/../../src/general/array_extensions'

describe Array do
  it "should unzip a serious of tuples" do
    zipped = [[1, 1], [2, 2], [3, 3]]
    zipped.unzip[0].should == [1, 2, 3]
    zipped.unzip[1].should == [1, 2, 3]
  end
end