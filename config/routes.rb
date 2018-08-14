Rails.application.routes.draw do
  resources :links, only: [:new, :index, :create, :show]
  root to: 'links#new'
end
