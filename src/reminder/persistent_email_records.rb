require 'date'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

#TODO: use YAML stuff instead
class PersistentEmailRecords
  def initialize
    @records_file = File.dirname(__FILE__) + '/../../resources/persistent_email_records.txt'
  end

  def num_reminders_already_sent_today
    its_a_new_day? ? 0 : recorded_value_of("NUM_REMINDERS_SENT_ALREADY_TODAY")
  end

  def save_num_reminders_sent_and_todays_wday(num_sent)
    record =  "NUM_REMINDERS_SENT_ALREADY_TODAY: #{num_sent}" << "\n"
    record << "LAST_PERSIST_WDAY: #{DateTime.now.wday}" << "\n"
    File.open(@records_file, 'w') { |f| f.write record }
  end

  private

  def its_a_new_day?
    recorded_value_of("LAST_PERSIST_WDAY") != DateTime.now.wday
  end

  def recorded_value_of(record_name)
    File.open(@records_file).find { |line| line =~ /#{record_name}:\s*(\d+)/ }
    $1.to_i
  end
end