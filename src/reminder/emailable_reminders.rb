require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/email/reminder_email_creator'
require File.dirname(__FILE__) + '/../../src/email/email_sender'

#TODO: figure out how to unit test each feature of this object, and do it
class EmailableReminders
  def initialize(*reminders)
    @reminders = reminders
    @history   = EmailHistory.new
  end

  def <<(reminder)
    @reminders << reminder
  end

  def send_reminders(recipients)
    if any_reminders_ready_to_send?
      recipients.each { |reminder| send_reminder(reminder) }
    end
  end

  private

  def send_reminder(recipient)
    email = ReminderEmailCreator.new.create_email(recipient, due_reminders)
    EmailSender.new.send_email(email, recipient.email_address)
    @history.save_num_reminders_sent_and_todays_wday(due_reminders.size)
  end

  #TODO put tests around this, especially cus I am unsure if it will work this way!
  def any_reminders_ready_to_send?
    due_reminders.size > @history.num_reminders_already_sent_today
  end

  def due_reminders
    @reminders.select { |r| r.due? }
  end
end