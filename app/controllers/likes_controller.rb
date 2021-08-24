class LikesController < ApplicationController

  before_action :authenticate_user!

  def to_like
    @tweet = Tweet.find(params[:id])
    new_like = Like.create(tweet: @tweet, user: current_user)
    redirect_to root_path
  end

  def to_dislike
    @tweet = Tweet.find(params[:id])
    like = @tweet.likes.find_by(user: current_user)
    like.destroy
    redirect_to root_path
  end
end
