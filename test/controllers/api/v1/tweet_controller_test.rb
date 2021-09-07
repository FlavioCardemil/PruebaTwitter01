require 'test_helper'

class Api::V1::TweetControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get api_v1_tweet_news_url
    assert_response :success
  end

end
