class ApplicationController < ActionController::Base
  before_action :authenticate_user

  rescue_from ResponseError do
    action
  end

  attr_reader :current_user

  private

  def authenticate_user
    @current_user = VerifyToken.new(cookies[:session_cookie], :session).call
  end

  def action
    redirect_to login_path
  end
end
