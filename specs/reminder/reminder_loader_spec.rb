require File.dirname(__FILE__) + '/../test_helpers'
require File.dirname(__FILE__) + '/../../src/reminder/reminder_loader'

describe ReminderLoader do
  it "loads all the reminders" do
    proc { ReminderLoader.load("file_name_thatdoes_not_exist.xyz") }.should raise_error
  end

  it 'reminder file exists'
end