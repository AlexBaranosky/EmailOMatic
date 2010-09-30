require "spec"
require File.dirname(__FILE__) + '/../../src/time/date_cycle'

class Cycle
  include DateCycle

  def valid?(t); true end
  def date_in_the_cycle?(d); true end
end

class DifferentClassOfCycle
  include DateCycle

  def valid?(t); true end
  def date_in_the_cycle?(d); true end
end

describe DateCycle do
  it "should check the classes are the same when evaluating equality" do
    Cycle.new(1).should_not == DifferentClassOfCycle.new(1)
    Cycle.new(1).should == Cycle.new(1)
  end
end

p [1].to_set