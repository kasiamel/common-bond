class ListsController < BaseController
  def show
    @list = List.find(params[:format])
  end

  def create
    submit_form(ListForm.new(current_user.lists.create))
  end
end
