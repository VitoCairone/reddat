Reddat::Application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :links
  resources :subs
  resources :comments

  get '/links/:id/upvote', to: 'links#upvote', as: 'link'
  get '/links/:id/downvote', to: 'links#downvote', as: 'link'
end
