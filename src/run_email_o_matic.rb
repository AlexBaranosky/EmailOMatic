require File.dirname(__FILE__) + '/../src/email_o_matic'
require File.dirname(__FILE__) + '/../src/email/email_recipient'

EmailOMatic.new.email_reminders_to(
    EmailRecipient.new('Alex', 'alex@gmail.com'),
    EmailRecipient.new('Zach',  'zach@yahoo.com'))