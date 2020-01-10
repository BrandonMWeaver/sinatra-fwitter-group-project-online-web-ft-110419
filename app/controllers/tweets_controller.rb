class TweetsController < ApplicationController
  
  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end
  
  get "/tweets/new" do
    unless logged_in?
      redirect "/login"
    end
    erb :"tweets/new"
  end
  
  post "/tweets" do
    if !params[:content].empty?
      tweet = Tweet.create(params)
      current_user.tweets << tweet
      redirect "/tweets/#{tweet.id}"
    end
    redirect "/tweets/new"
  end
  
  get "/tweets/:id" do
    binding.pry
    if logged_in? && current_user.tweet_ids.include?(params[:id].to_i)
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    end
    redirect "/login"
  end
  
end
