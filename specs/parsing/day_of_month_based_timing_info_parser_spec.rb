require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/timing_info_parser'
require File.dirname(__FILE__) + '/../../src/time/days_of_month'

describe DayOfMonthBasedTimingInfoParser do
  parser = DayOfMonthBasedTimingInfoParser.new

  it 'should parse timing infos from ordinal numbers' do
    parser.parse('Every 15th of the month').should == TimingInfo.new(DaysOfMonth.new(15))
    parser.parse('Every 1st of the month').should == TimingInfo.new(DaysOfMonth.new(1))
    parser.parse('Every 2nd of the month').should == TimingInfo.new(DaysOfMonth.new(2))
    parser.parse('Every 3rd of the month').should == TimingInfo.new(DaysOfMonth.new(3))
    parser.parse('Every 21st of the month').should == TimingInfo.new(DaysOfMonth.new(21))
    parser.parse('Every 22nd of the month').should == TimingInfo.new(DaysOfMonth.new(22))
    parser.parse('Every 23rd of the month').should == TimingInfo.new(DaysOfMonth.new(23))
    parser.parse('Every 31st of the month').should == TimingInfo.new(DaysOfMonth.new(31))
  end

  it 'should fail to parse timing infos from improper ordinal numbers' do
    proc { parser.parse('Every 15st of the month') }.should raise_error
    proc { parser.parse('Every 15nd of the month') }.should raise_error
    proc { parser.parse('Every 15rd of the month') }.should raise_error
  end

  it 'should parse multiple timing infos out of a day of week based string' do
    parser.parse(' Every 15th of the month & Every 22nd of the month ').should == TimingInfo.new(DaysOfMonth.new(15, 22))
  end

  it 'should ignore case when parsing timing infos' do
    parser.parse('EvERy 15TH of THE month').should == TimingInfo.new(DaysOfMonth.new(15))
  end
end