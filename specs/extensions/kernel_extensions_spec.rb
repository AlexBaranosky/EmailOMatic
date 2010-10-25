require "rspec"
require File.dirname(__FILE__) + '/../../src/extensions/kernel_extensions'

describe Kernel do
  it "add a default equals method to any class to compare each field for equality" do
    # same fields, same classes, different reference
    SubObject1.new.should_not == SubObject1.new

    add_equals_method :SubObject1

    # same class, same field, so equal
    obj1 = SubObject1.new
    obj2 = SubObject1.new
    obj1.should == obj2

    # field value changes, so not equal, even though clases are same
    obj1.field = "new stuff"
    obj1.should_not == obj2

    # same fields different classes
    SubObject1.new.should_not == SubObject2.new
  end
end

class MyObject
  attr_accessor :field
  def initialize
    @field = "value"
  end
end

class SubObject1 < MyObject
   #different classes
end

class SubObject2 < MyObject
  #different classes
end