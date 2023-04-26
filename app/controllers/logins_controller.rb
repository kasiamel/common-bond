class LoginsController < BaseController
  skip_before_action :authenticate_user, only: :create

  def show
    redirect_to dashboard_path if @current_user.present?
  end

  def create
    @session = create_session

    return unless @session.present?

    cookies[:session_cookie] = @session.cookie
    redirect_to dashboard_path
  end

  def destroy
    cookies.delete('session_cookie')
    flash[:notice] = 'You have successfully logged out.'
    redirect_to login_url
  end

  private

  def create_session
    @session ||= CreateSession.new(params[:email], params[:password]).call
  end

  def action
    flash.now[:alert] = 'Incorrect email or password. Please try again.'
    render action: 'show'
  end
end
