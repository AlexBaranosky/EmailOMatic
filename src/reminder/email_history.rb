require 'date'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

#TODO: use YAML stuff instead
class EmailHistory
  def initialize
    @history_file = File.dirname(__FILE__) + '/../../resources/persistent_email_records.txt'
  end

  def num_reminders_already_sent_today
    its_a_new_day? ? 0 : historical_value_of("NUM_REMINDERS_SENT_ALREADY_TODAY")
  end

  def save_num_reminders_sent_and_todays_wday(num_sent)
    history =  "NUM_REMINDERS_SENT_ALREADY_TODAY: #{num_sent}" << "\n"
    history << "LAST_PERSIST_WDAY: #{DateTime.now.wday}" << "\n"
    File.open(@history_file, 'w') { |f| f.write history }
  end

  private

  def its_a_new_day?
    historical_value_of("LAST_PERSIST_WDAY") != DateTime.now.wday
  end

  def historical_value_of(history_field)
    File.open(@history_file).find { |line| line =~ /#{history_field}:\s*(\d+)/ }
    $1.to_i
  end
end