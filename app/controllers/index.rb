get '/' do
  # Look in app/views/index.erb
  erb :index
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
    redirect to '/profile/:id'
  end
end

get '/profile/:id', :auth => :user do
  @username = @user.user_name
  @tweets = Array(@user.tweets.map{|t|t.text})

  erb :profile
end

get '/profile/followers' do
  @followers = @user.stalkers
  erb :see_followers
end

get '/profile/following' do
  @following = @user.honchos
  erb :see_following
end

post '/logout' do
  session[:id] = nil
  redirect to '/'
end
