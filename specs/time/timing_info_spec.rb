require 'rspec'
require File.dirname(__FILE__) + '/../../src/time/timing_info'

describe TimingInfo do
  it 'should tell the next date time in the future' do
    timing_info = TimingInfo.new([DateTime.parse("2004/4/1"), DateTime.parse("2004/5/1")])
    timing_info.next_time.should == DateTime.parse("2004/4/1")
  end
end