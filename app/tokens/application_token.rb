class ApplicationToken
  def generate
    JWT.encode(payload, nil)
  end

  private

  def payload
    { type:, exp: expires_at.to_i }
  end

  def type
    self.class.name.underscore.rpartition('_')[0]
  end

  def expires_at
    48.hours.from_now
  end
end
