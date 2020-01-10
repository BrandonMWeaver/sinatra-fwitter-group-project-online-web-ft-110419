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
    erb :"tweets/new" if logged_in?
    redirect "/login"
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
    end
    redirect "/login"
  end
  
end
