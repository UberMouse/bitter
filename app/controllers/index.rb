get '/' do
  if authorized?
    @tweets = @user.get_honcho_tweets
    erb :index
  else
    erb :login
  end
end

post '/create' do
  @user = User.create(name: params[:name],
                  email: params[:email],
                  user_name: params[:user_name],
                  password: params[:password])
  session['id'] = @user.id
  redirect to '/profile'
end

post '/login' do
 @user = User.authenticate(params[:user_name], params[:password])
  if @user == nil
    redirect to '/'
  else
    session['id'] = @user.id
    @id  = @user.id
    redirect to "/users/#{@user.user_name}"
  end
end

get '/users/:user_name' do
  user = User.find_by_user_name(params[:user_name])
  @username = user.user_name
  @tweets = user.tweets.map(&:get_presentation_deets)
  @gravatar_url = @user.gravatar_url
  @honcho_count = user.honchos.length
  @stalkers_count = user.stalkers.length
  @userid = user.id
  @stalk_button_message = @user.honchos.include?(user) ? 'Unstalk' : 'Stalk'
  if user.id == @user.id
    @stalk_button_message = ''
  end

  erb :profile
end


get '/logout' do
  session[:id] = nil
  redirect to '/'
end

get '/favorites' do
  @favorites = @user.favorited_tweets.map(&:get_presentation_deets)
  erb :favorites
end
