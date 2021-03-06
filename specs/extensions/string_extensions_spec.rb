require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/extensions/string_extensions'

describe String do
  it 'should tell if it is blank' do
    ''.blank?.should == true
    ' '.blank?.should == true
    'XXXXXX'.blank?.should == false
  end
  
  it 'should tell if it matches a regex' do
    'a'.matches?(/a/).should == true
    ' '.matches?(/a/).should == false
  end
end