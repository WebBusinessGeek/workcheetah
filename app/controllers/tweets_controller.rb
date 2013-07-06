class TweetsController < ApplicationController
  load_and_authorize_resource

  # GET /tweets
  # GET /tweets.json
  def index
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  # GET /tweets/new.json
  def new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
      else
        format.html { render action: "new" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update_attributes(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end

private
  def tweet_params
    params.require(:tweet).permit(:body, :for_accounts, :for_public, :for_resumes)
  end
end
