require 'rspec'
require File.dirname(__FILE__) + '/../../src/parsing/calendar_parser'

describe DateBasedCalendarParser do
  parser = DateBasedCalendarParser.new

  it 'can parse properly formatted strings' do
    DateBasedCalendarParser.can_parse?('2010 1 25').should == true
  end

  it 'should parse timing infos out of a date based string' do
    parser.parse(' 2010 1 25  ').should == Calendar.new([DateTime.civil(2010, 1, 25)])
  end

  it 'should parse multiple timing infos out of a date based string' do
    parser.parse(' 2010 1 25 & 2000 5 29 ').should == Calendar.new([DateTime.civil(2010, 1, 25), DateTime.civil(2000, 5, 29)])
  end
end