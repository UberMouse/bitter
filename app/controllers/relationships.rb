get '/users/:user_name/stalkers' do
  user = User.find_by_user_name(params[:user_name])
  @header = "Stalkers"
  @users = user.stalkers
  erb :see_user_list
end

get '/users/:user_name/honchos' do
  user = User.find_by_user_name(params[:user_name])
  @header = "Honchos"
  @users = user.honchos
  erb :see_user_list
end

get '/stalk/:user_id' do
  user = User.find(params[:user_id])
  if @user.honchos.include? user
    @user.unhoncho user
    user.remove_stalker @user
  else
    @user.add_honcho user
    user.add_stalker @user
  end

  redirect to(request.referer)
end