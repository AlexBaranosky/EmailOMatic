require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/timing_info_parser'

describe TimingInfoParser do

  it 'should create a date based timing info parser' do
    should_create_proper_parser(' 2000 1 2  & 2000 1 2   ', DateBasedTimingInfoParser)
  end

  it 'should create a day of week based timing info parser' do
    should_create_proper_parser(' Sundays & Saturdays', DayOfWeekBasedTimingInfoParser)
  end

  it 'should create a day of month based timing info parser' do
    should_create_proper_parser(' Every 6th of the month  & Every 8th of the month', DayOfMonthBasedTimingInfoParser)
  end
  
  it 'should raise error if bad string' do
    proc { TimingInfoParser.new(" SCREWED UP LINE OF UNPARSEABLE STUFF ") }.should raise_error
  end

  def should_create_proper_parser(string, parser_type)
     TimingInfoParser.new(string).instance_of?(parser_type).should == true
  end
end