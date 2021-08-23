class AddRetweetsToTweets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :tweet_id, foreign_key: true
  end
end
