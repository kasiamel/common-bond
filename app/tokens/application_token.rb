class ApplicationToken
  def generate
    JWT.encode(payload, ENV.fetch('HMAC_SECRET'), 'HS256')
  end

  private

  def payload
    { type: type, exp: expires_at.to_i }
  end

  def type
    self.class.name.underscore.rpartition('_')[0]
  end

  def expires_at
    48.hours.from_now
  end
end
