require 'rspec'
require 'date'
require File.dirname(__FILE__) + '/../../src/time/calendar'

describe Calendar do
  it 'should tell the next date time in the future' do
    timing_info = Calendar.new([DateTime.parse("3000/4/1"), DateTime.parse("3000/5/1")])
    timing_info.next_time.should == DateTime.parse("3000/4/1")
  end
end