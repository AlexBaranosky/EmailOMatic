class EmailRecipient
  attr_reader :name, :email_address

  def initialize(name, email_address)
    @name, @email_address = name, email_address
  end
end