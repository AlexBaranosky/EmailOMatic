require 'spec'
require File.dirname(__FILE__) + '/../../src/parsing/timing_info_parser'

describe DateBasedTimingInfoParser do
  parser = DateBasedTimingInfoParser.new

  it 'can parse properly formatted strings' do
    DateBasedTimingInfoParser.can_parse?('2010 1 25').should == true
  end

  it 'should parse timing infos out of a date based string' do
    parser.parse(' 2010 1 25  ').should == TimingInfo.new([DateTime.civil(2010, 1, 25)])
  end

  it 'should parse multiple timing infos out of a date based string' do
    parser.parse(' 2010 1 25 & 2000 5 29 ').should == TimingInfo.new([DateTime.civil(2010, 1, 25), DateTime.civil(2000, 5, 29)])
  end
end