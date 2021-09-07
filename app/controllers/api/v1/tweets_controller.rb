class Api::V1::TweetsController < ActionController::API

include ActionController::HttpAuthentication::Basic::ControllerMethods
http_basic_authenticate_with name: "lal", password: "123456", except: [:news, :by_date]
  
  def news
    @tweets = Tweet.last(50)
    @tweetapi = []
    @tweets.each do |tweet|
      @tweetapi.push(
        id: tweet.id, 
        content: tweet.content, 
        user_id: tweet.user_id, 
        like_count: tweet.likes.count, 
        retweet_count: tweet.retweets.count,
        rewtitted_from: tweet.retweets.name
        )
    end
    render json: @tweetapi
  end

  def by_date
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @tweets_by_date = Tweet.where('created_at BETWEEN ? AND ?', @start_date, @end_date)
    @tweetapi = []
    @tweets_by_date.each do |tweet|
      @tweetapi.push(
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        like_count: tweet.likes.count,
        retweet_count: tweet.retweets.count
        )
    end
    render json: @tweetapi
  end

  private

  def params_tweet
    params.require(:tweet).permit(:content)
  end

end