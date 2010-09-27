require 'spec'
require 'rr'
require File.dirname(__FILE__) + '/../specs/test_classes/fake_emailer'
require File.dirname(__FILE__) + '/../src/email_o_matic'
require File.dirname(__FILE__) + '/../src/email/email_recipient'

describe EmailOMatic do
  #TODO: this test is pathetic.  Fix that.
  it "should do something" do
    recipients = [EmailRecipient.new('Alex', 'alex@gmail.com'),
                  EmailRecipient.new('Zach',  'zach@yahoo.com')]

    email_o_matic = EmailOMatic.new(FakeEmailer.new)
    email_o_matic.email_reminders_to(recipients)
  end
end