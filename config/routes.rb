Rails.application.routes.draw do
  resources :links, only: [:new, :index, :create, :show]
  namespace :admin do
    resources :links, only: [:edit, :update]
  end
  root to: 'links#new'
end
