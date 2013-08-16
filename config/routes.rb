Reddat::Application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :links do
    member do
      get 'upvote'
      get 'downvote'
    end
  end
  resources :subs
  resources :comments
end
