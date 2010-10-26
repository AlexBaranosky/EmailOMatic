require File.dirname(__FILE__) + '/../../src/reminder/email_history'
require File.dirname(__FILE__) + '/../../src/email/reminder_email_creator'
require File.dirname(__FILE__) + '/../../src/email/email_sender'

class EmailableReminders
  def initialize(*reminders)
    @reminders = reminders
    @history   = EmailHistory.new
  end

  def <<(reminder)
    @reminders << reminder
  end

  def send_reminders(recipient)
    if any_reminders_ready_to_send?
      reminders_to_send = due_reminders
      email             = ReminderEmailCreator.new.create_email(recipient, reminders_to_send)
      EmailSender.new.send_email(email, recipient.email_address)
      @history.save_num_reminders_sent_and_todays_wday(reminders_to_send.size)
    end
  end

  private

  #TODO: if I add and remove a reminder in one day this will not register as there being any new due reminders, since total stays constant
  # consider storing a true history of all messages on all reminders sent today, and comparing vs that to evaluate the below method
  def any_reminders_ready_to_send?
    due_reminders.size > @history.num_reminders_already_sent_today
  end

  def due_reminders
    @reminders.select { |r| r.due? }
  end
end