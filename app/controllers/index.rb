get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/create' do
  @user = User.create(name: params[:name],
                  email: params[:email],
                  user_name: params[:user_name],
                  password: params[:password])
  session["id"] = @user.id
  erb :profile
end

post '/login' do
 @user = User.authenticate(params[:user_name], params[:password])
  if @user == nil
    redirect to '/'
  else
    session["id"] = @user.id
    redirect to '/profile'
  end
end

get '/profile' do
  @username = 'ubermouse'
  @tweets = ['trololol', 'my tweets are dum', 'lol']
  erb :profile
end

post '/logout' do
  session[:id] = nil
  redirect to '/'
end
