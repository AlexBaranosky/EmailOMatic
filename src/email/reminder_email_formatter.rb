class ReminderEmailFormatter
  def format_due_reminders_for_email(reminders)
    due_reminders = reminders.reminders_ready_to_be_sent

    "The following reminders are coming up for tomorrow and the day after tomorrow: \n\n" +
    due_reminders.each_with_index.map { |r, i| format_reminder(i, r) }.join("\n\n")
  end

  private

  def format_reminder(idx, reminder)
    soonest_reminder_time = reminder.next_time_to_remind
    "#{(idx + 1)}. #{soonest_reminder_time.as_day} #{soonest_reminder_time.m_d_y}\n#{reminder.message}"
  end
end