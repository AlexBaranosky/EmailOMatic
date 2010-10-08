require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'

class GroupOfReminders
  def initialize(*reminder_list)
    @reminder_list = reminder_list
    @email_records = PersistentEmailRecords.new
  end

  def <<(reminder)
    @reminder_list << reminder
  end

  def ready_to_be_sent?
    reminders_ready_to_be_sent.size > @email_records.num_reminders_already_sent_today
  end

  def persist_due_reminder_count_and_day
    @email_records.record_num_of_reminders_and_todays_wday_value(reminders_ready_to_be_sent)
  end

  def reminders_ready_to_be_sent
    @reminder_list.select { |r| r.days_from_now_due? 5 }
  end
end