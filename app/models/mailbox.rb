class Mailbox

  include Redis::Objects
  redis_id_field :email

  KEY_TTL = 60 * 5

  def initialize(email)
    @email = email
  end

  def add_message(message)
    messages << message
    messages.expire(KEY_TTL)
  end

  def as_json(options = {})
    messages.to_a
  end

  attr_reader :email

  list :messages, marshal: true
end
