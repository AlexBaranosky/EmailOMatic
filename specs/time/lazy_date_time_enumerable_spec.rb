require "rspec"
require File.dirname(__FILE__) + '/../../src/time/lazy_date_time_enumerable'

class Cycle
  include LazyDateTimeEnumerable

  def valid?(t); true end
  def date_in_the_cycle?(d); true end
end

class DifferentClassOfCycle
  include LazyDateTimeEnumerable

  def valid?(t); true end
  def date_in_the_cycle?(d); true end
end

describe LazyDateTimeEnumerable do
  it "should check the classes are the same when evaluating equality" do
    Cycle.new(1).should_not == DifferentClassOfCycle.new(1)
    Cycle.new(1).should == Cycle.new(1)
  end
end