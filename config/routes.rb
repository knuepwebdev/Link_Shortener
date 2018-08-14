Rails.application.routes.draw do
  resources :links, only: [:new, :index]
end
