require File.dirname(__FILE__) + '/../../src/reminder/persistent_email_records'

class EmailableReminders
  def initialize(*reminders)
    @reminders     = reminders
    @email_records = PersistentEmailRecords.new
  end

  def <<(reminder)
    @reminders << reminder
  end

  def send_reminders(recipient)
    if any_reminders_ready_to_send?
      email = ReminderEmailCreator.new.create_email(recipient, due_reminders)
      EmailSender.new.send_email(email, recipient.email_address)
      @email_records.record_num_of_reminders_and_todays_wday_value(due_reminders)
    end
  end

  private

  #TODO: if I add and remove a reminder in one day this will not register as there being any new due reminders, since total stays constant
  def any_reminders_ready_to_send?
    due_reminders.size > @email_records.num_reminders_already_sent_today
  end

  def due_reminders
    @reminders.select { |r| r.days_from_now_due? 5 }
  end
end