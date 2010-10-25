require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/extensions/date_extensions'

describe Date do
  SUNDAY = Date.civil(2010, 8, 8)
  MONDAY = Date.civil(2010, 8, 9)
  TUESDAY = Date.civil(2010, 8, 10)
  WEDNESDAY = Date.civil(2010, 8, 11)
  A_THURSDAY = Date.civil(2010, 8, 12)
  FRIDAY = Date.civil(2010, 8, 13)
  SATURDAY = Date.civil(2010, 8, 14)

  it 'should be convertable to a day string' do
    SUNDAY.as_day.should == 'Sundays'
    MONDAY.as_day.should == 'Mondays'
    TUESDAY.as_day.should == 'Tuesdays'
    WEDNESDAY.as_day.should == 'Wednesdays'
    A_THURSDAY.as_day.should == 'Thursdays'
    FRIDAY.as_day.should == 'Fridays'
    SATURDAY.as_day.should == 'Saturdays'
  end

  it 'should be convertable to a string in m/d/y format' do
    Date.civil(2010, 1, 2).m_d_y.should == '1/2/2010'
  end
end