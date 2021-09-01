class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy retweet ]

  # GET /tweets or /tweets.json
  def index

    if params[:q]
      @tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").order(created_at: :desc).page params[:page]
    # elsif user_signed_in?
      # @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.eager_load(:user, :likes).order(created_at: :desc).page params[:page]
    end

    @tweet = Tweet.new
    @user_likes = Like.where(user: current_user).pluck(:tweet_id)
    @users = User.where.not(id: current_user.id).last(3) if user_signed_in?
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    @tweet_likes = @tweet.likes
  end

  def retweet
    new_tweet = Tweet.create(content: "RT: @#{@tweet.user.name}: '#{@tweet.content} ' ", user: current_user)
    @tweet.retweets.push(new_tweet)
    redirect_to root_path
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet creado felizmente." }
        format.json { redirect_to root_path, status: :created, location: @tweet }
      else
        format.html { redirect_to root_path, notice: "No se puede tuitear nada." }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
