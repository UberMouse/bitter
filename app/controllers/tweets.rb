get '/tweet' do
  erb :create_tweet
end

post '/tweet' do
  user = User.find(session['id'])
  tweet = Tweet.create(text: params[:tweet])
  user.tweets << tweet

  if tweet.valid?
    erb :tweet_created
  else
    @tweet = tweet.text
    @error = 'too many characters'
    erb :create_tweet
  end
end

get '/retweet/:tweet_id' do
  tweet = Tweet.find(params['tweet_id'])
  @user.tweets.create(text: tweet.text, retweet_id: tweet.id)

  redirect to request.referer
end

get '/favorite/:tweet_id' do
  tweet = Tweet.find(params[:tweet_id])
  @user.favorites.create(user_id: @user.id, tweet_id: tweet.id)
  redirect to request.referer
end