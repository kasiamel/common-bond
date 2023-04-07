class Session
  def initialize(user)
    @user = user
  end

  def cookie
    { value: token, expires: 1.month.from_now, http_only: true }
  end

  def token
    SessionToken.new(@user).generate
  end
end
