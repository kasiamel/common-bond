class BaseController < ApplicationController
  before_action :authenticate_user

  attr_reader :current_user

  private

  def authenticate_user
    @current_user = VerifyToken.new(cookies[:session_cookie], :session).call
  end
end
