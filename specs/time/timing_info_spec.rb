require 'spec'
require File.dirname(__FILE__) + '/../../src/time/timing_info'

describe TimingInfo do
  it 'should tell the next date time in the future' do
    timing_info = TimingInfo.new([DateTime.civil(3000, 1, 1), DateTime.civil(3000, 2, 1)])
    timing_info.next_time.should == DateTime.civil(3000, 1, 1)
  end
end