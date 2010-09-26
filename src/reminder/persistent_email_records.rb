require 'date'
require File.dirname(__FILE__) + '/../../src/general/enumerable_monkey_patch'

class PersistentEmailRecords
  def initialize(num_records_sent_records_file = File.dirname(__FILE__) + '/../../resources/persistent_email_records.txt')
    @num_records_sent_records_file = num_records_sent_records_file
  end

  def num_reminders_already_sent_today
    return 0 if its_a_new_day?
    persisted_value_of_num_of_reminders_last_sent
  end


  def record_num_of_reminders_and_todays_wday_value(due_reminder_list)
    File.open(@num_records_sent_records_file, 'w') do |f|
      f.write("#{due_reminder_list.size}\n#{today}\n")   
    end
  end

  private

  def its_a_new_day?; persisted_value_of_wday_of_last_persist_time != today end

  def today; DateTime.now.wday end

  def persisted_value_of_num_of_reminders_last_sent
    File.open(@num_records_sent_records_file).first  { |line| line }.to_i
  end

  def persisted_value_of_wday_of_last_persist_time
    File.open(@num_records_sent_records_file).second { |line| line }.to_i
  end
end