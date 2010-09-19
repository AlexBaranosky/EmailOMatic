require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/reminder_timing_info_parser'

describe DateBasedTimingInfoParser do
  parser = DateBasedTimingInfoParser.new

  it 'should parse timing infos out of a date based string' do
    parser.parse(' 1 2 3  ').should == ReminderTimingInfo.new([DateTime.civil(1, 2, 3)], [1])
  end

  it 'should parse multiple timing infos out of a date based string' do
    parser.parse(' 1 2 3 & 4 5 6 ').should == ReminderTimingInfo.new([DateTime.civil(1, 2, 3), DateTime.civil(4, 5, 6)], [1, 1])
  end
end