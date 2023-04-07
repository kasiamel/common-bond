Rails.application.routes.draw do
  root "logins#show"

  resource :login, only: [:show, :create, :destroy]
  resource :dashboard, only: :show
end
