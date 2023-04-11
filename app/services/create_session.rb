class CreateSession
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    password_valid? ? generate_session : raise_error
  end

  private

  def password_valid?
    user&.authenticate(@password)
  end

  def user
    @user ||= User.find_by(email: @email)
  end

  def generate_session
    Session.new(user)
  end

  def raise_error
    raise ResponseError, :forbidden
  end
end
