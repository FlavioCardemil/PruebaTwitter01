Rails.application.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'news', to: 'tweets#news'
      get ':start_date/:end_date', to: 'tweets#by_date'
      post 'tweet_api', to: 'tweets#tweet_api'
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'tweets#index'
  resources :tweets
  post 'tweet/retweet/:id', to: 'tweets#retweet', as: 'retweet'
  post 'likes/:id', to: 'likes#to_like', as: 'like'
  delete 'likes/:id', to: 'likes#to_dislike', as: 'dislike'
  post 'follows/:id', to: 'follows#to_follow', as: 'follow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
