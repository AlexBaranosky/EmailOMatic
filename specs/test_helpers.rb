require 'rspec'
require 'rr'
require 'timecop'
require File.dirname(__FILE__) + '/../src/extensions/kernel_extensions'

#TODO: <PRIORITY HIGH 1> use something like the below to make RR stubbing go away after this test is over; so to not pollute the rest of the tests
#RSpec.configure do |config|
#  config.mock_with :rr
#end