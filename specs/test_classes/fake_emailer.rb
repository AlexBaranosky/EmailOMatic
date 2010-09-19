class FakeEmailer
  
  FAKE_EMAIL_OUTPUT = File.dirname(__FILE__) + '/../../resources/fake_email_output.txt'

  def  send_email(reminders, recipients)
    header = "Email***************************************************\n\n"
    footer = "\n\n********************************************************\n\n"
    email = header + reminders.to_s + footer + "\n"
    File.open(FAKE_EMAIL_OUTPUT, 'a') {|f| f.write(email)}
  end
end