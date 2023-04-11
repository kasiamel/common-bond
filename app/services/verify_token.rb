class VerifyToken
  def initialize(token, type)
    @token = token
    @type = type
  end

  def call
    find_user if @token && type_valid?
  rescue JWT::ExpiredSignature
    raise_error
  end

  private

  def payload
    @payload ||= JWT.decode(@token, ENV.fetch('HMAC_SECRET'), true,
                            { algorithm: 'HS256' })[0] || {}
  end

  def type_valid?
    payload['type'] == @type.to_s
  end

  def find_user
    User.find(@payload['user_id'])
  end

  def raise_error
    raise ResponseError, :forbidden
  end
end
