class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    @email.to.map { |e| e[:full] }.each do |email|
      Mailbox.new(email).add_message(@email.as_json)
    end
  end
end
