require 'rspec'
require 'timecop'
require File.dirname(__FILE__) + '/../src/extensions/kernel_extensions'

RSpec.configure do |config|
  config.mock_with :rr
end