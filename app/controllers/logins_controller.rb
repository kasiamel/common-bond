class LoginsController < ApplicationController
  def show; end

  def create
    @session = create_session

    if @session.present?
      cookies[:session_cookie] = @session.cookie
      redirect_to dashboard_path
    else
      flash.now[:alert] = 'Incorrect email or password. Please try again.'
      render action: 'show'
    end
  end

  def destroy
    cookies.delete('session_cookie')
    flash[:notice] = 'You have successfully logged out.'
    redirect_to login_url
  end

  private

  def create_session
    @create_session ||= CreateSession.new(params[:email], params[:password]).call
  end
end
