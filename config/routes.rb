Rails.application.routes.draw do
  resources :links, only: [:new, :index, :create, :show]
  get '/decode/:id', to: 'links#decode', as: :decode_link
  namespace :admin do
    resources :links, only: [:edit, :update, :show]
  end
  root to: 'links#new'
end
