module RequestHelpers
  def set_session_cookie
    cookies[:session_cookie] = token
  end

  def token
    SessionToken.new(current_user).generate
  end

  def current_user
    @current_user ||= create(:user)
  end
end
