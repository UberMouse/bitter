before do
  if session['id'].present?
    unless User.exists? id: session['id']
      session['id'] = nil
      return
    end
    @user = User.find(session['id'])
  end
end

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
  redirect to '/profile'
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
  @username = @user.user_name
  @tweets = Array(@user.tweets.map{|t|t.text})

  erb :profile
end

post '/logout' do
  session[:id] = nil
  redirect to '/'
end
