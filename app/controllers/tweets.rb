get '/tweet' do
  erb :create_tweet
end

post '/tweet' do
  user_id = 1
  tweet = params[:tweet]

  tweet = Tweet.create(text: tweet, user_id: user_id)

  if tweet.valid?
    erb :tweet_created
  else
    @tweet = tweet.text
    @error = 'too many characters'
    erb :create_tweet
  end
end