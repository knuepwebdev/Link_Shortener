Rails.application.routes.draw do
  resources :links, only: [:new, :index, :create]
  root to: 'links#new'
end
