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
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end
  
  get "/tweets/:id/edit" do
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      redirect "/login"
    end
  end
  
  patch "/tweets/:id/edit" do
    erb :"tweets/:id/edit"
  end
  
  delete "/tweets/:id" do
    tweet = Tweet.find(params[:id])
    tweet.delete if current_user.tweets.include?(tweet)
    redirect "/tweets"
  end
  
end
