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