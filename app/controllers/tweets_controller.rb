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
    if logged_in?
      erb :"tweets/new"
    end
    redirect "/login"
  end
  
  post "/tweets/new" do
    if !params[:content].empty?
      tweet = Tweet.create(params)
      tweet.user_id = current_user.id
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
