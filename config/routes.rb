Rails.application.routes.draw do
  root "logins#show"

  resource :login, only: [:show, :create, :destroy]
  resource :dashboard, only: :show

  get 'logout', to: 'logins#destroy', as: :logout
end
