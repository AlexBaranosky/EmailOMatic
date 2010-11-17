require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/extensions/kernel_extensions'

describe Kernel do

  it "adds default equals method to any classes within a given block, after which the method goes away" do
    add_equals_method(:SubObject1) do
      SubObject1.new.should == SubObject1.new
    end
    SubObject1.new.should_not == SubObject1.new
  end

  it "aliases == method to __old_equals, when applying new default ==" do
    add_equals_method(:SubObject1) do
      SubObject1.new.__old_equals2917(SubObject1.new).should == false #using == by reference from Object
    end
    SubObject1.new.respond_to?(:__old_equals2917).should == false
    SubObject1.new.should_not == SubObject1.new
  end

  it "doesn't put the equals back to not existing if the class had no equals to begin with" do
    ClassWithNoEquals.new.respond_to?(:==).should == false

    add_equals_method(:ClassWithNoEquals) do
      ClassWithNoEquals.new.respond_to?(:__old_equals2917).should == false
      ClassWithNoEquals.new.should == ClassWithNoEquals.new
    end
    object = ClassWithNoEquals.new
    object.should == object
  end

  it "removes equals method left from last test" do
    SubObject1.new.should_not == SubObject1.new
    add_equals_method :SubObject1
    SubObject1.new.should == SubObject1.new
    remove_equals_method :SubObject1
    SubObject1.new.should_not == SubObject1.new
  end

  it "add a default equals method to any class to compare each field for equality" do
    # same fields, same classes, different reference
    SubObject1.new.should_not == SubObject1.new

    add_equals_method :SubObject1

    # same class, same field, so equal
    SubObject1.new.should == SubObject1.new

    # field value changes, so not equal, even though classes are same
    obj       = SubObject1.new
    obj.field = "new stuff"
    SubObject1.new.should_not == obj

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

class ClassWithNoEquals < MyObject
  undef_method :==
end

describe WithDefaultEquals do
  it 'adds an equals method to the object it mixes into' do
    SubObject1.new.should_not == SubObject1.new
    class SubObject1; include WithDefaultEquals end
    SubObject1.new.should == SubObject1.new
  end
end