require File.dirname(__FILE__) + '/../../src/extensions/date_extensions'

class ReminderEmailCreator
  FROM    = %Q|"EmailOMatic Reminder Service" <>|

  def create_email(recipient, reminders)
    body = create_email_body(reminders)

    header = <<MESSAGE_END
From:     #{FROM}
To: "    #{recipient.name}    " <    #{recipient.email_address}    >
Subject: EmailOMatic Reminder Service
MESSAGE_END

    header + body
  end

  private

  def create_email_body(reminders)
    "The following reminders are coming up for tomorrow and the day after tomorrow: \n\n" +
        reminders.map.with_index { |r, i| format_reminder(r, i) }.join("\n\n")
  end

  #TODO: move some of this to Reminder to_s
  def format_reminder(reminder, idx)
    reminder_date = reminder.next_date_time
    "#{(idx + 1)}. #{reminder_date.as_day} #{reminder_date.m_d_y}\n#{reminder.message}"
  end
end