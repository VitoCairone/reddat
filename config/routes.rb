Reddat::Application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :links
  resources :subs
end
