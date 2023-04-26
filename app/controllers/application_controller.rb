class ApplicationController < ActionController::Base
  rescue_from ResponseError do
    action
  end

  private

  def action
    redirect_to login_path
  end

  def submit_form(form)
    if form.validate(params.to_unsafe_hash)
      form.save
      redirect_to form.model
    else
      flash.now[:alert] = form.errors.to_a.join(', ')
      render action: 'create', status: :bad_request
    end
  end
end
