require 'date'
require 'yaml'
require File.dirname(__FILE__) + '/../../src/extensions/enumerable_extensions'

class EmailHistory
  HISTORY_FILE = File.dirname(__FILE__) + '/../../resources/email_history.yaml'

  def initialize
    @history = YAML.load_file HISTORY_FILE
  end

  def num_reminders_already_sent_today
    @history['weekday last saved on'] == DateTime.now.wday ? @history['num reminders already sent today'] : 0
  end

  def save_num_reminders_sent_and_todays_wday(num_sent)
    @history['num reminders already sent today'] = num_sent
    @history['weekday last saved on']        = DateTime.now.wday
    File.open(HISTORY_FILE, 'w') { |f| f.write @history.to_yaml }
  end
end