Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets
  post 'tweet/retweet/:id', to: 'tweets#retweet', as: 'retweet'
  post 'likes/:id', to: 'likes#to_like', as: 'like'
  delete 'likes/:id', to: 'likes#to_dislike', as: 'dislike'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
