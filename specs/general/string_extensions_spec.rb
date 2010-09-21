require 'spec'
require File.dirname(__FILE__) + '/../../src/general/string_extensions'

describe String do
  it 'should tell if it is blank' do
    ''.blank?.should == true
    ' '.blank?.should == true
    'XXXXXX'.blank?.should == false
  end
end