get '/' do
  if authorized?
    honchos = @user.honchos
    honcho_tweets = honchos.map{|h| h.tweets}.flatten

    @tweets = []
    until @tweets.length == 30
      tweet_text = honcho_tweets.sample.text
      @tweets << tweet_text unless @tweets.include? tweet_text
    end
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

get '/users/:user_name', :auth => :user do
  user = User.find_by_user_name(params[:user_name])
  @username = user.user_name
  @tweets = Array(user.tweets.map{|t|t.text})
  erb :profile
end

get '/users/:user_name/stalkers' do
  @header = "Stalkers"
  @users = @user.stalkers
  erb :see_user_list
end

get '/users/:user_name/honchos' do
  @header = "Honchos"
  @users = @user.honchos
  erb :see_user_list
end

get '/logout' do
  session[:id] = nil
  redirect to '/'
end
