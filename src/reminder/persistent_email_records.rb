require 'date'
require File.dirname(__FILE__) + '/../../src/general/enumerable_monkey_patch'

class PersistentEmailRecords
  def initialize(records_file = File.dirname(__FILE__) + '/../../resources/persistent_email_records.txt')
    @records_file = records_file
  end

  def num_reminders_already_sent_today
    return 0 if its_a_new_day?
    recorded_value_of("NUM_REMINDERS_SENT_ALREADY_TODAY")
  end


  def record_num_of_reminders_and_todays_wday_value(due_reminder_list)
    File.open(@records_file, 'w') do |f|
      record =  "NUM_REMINDERS_SENT_ALREADY_TODAY: #{due_reminder_list.size}" << "\n"
      record << "LAST_PERSIST_WDAY: #{today}" << "\n"
      f.write(record)
    end
  end

  private

  def its_a_new_day?
    recorded_value_of("LAST_PERSIST_WDAY") != DateTime.now.wday
  end

  def recorded_value_of(line_marker)
    File.open(@records_file).find { |line| line =~ /#{line_marker}:\s*(\d+)/ }
    $1.to_i
  end
end