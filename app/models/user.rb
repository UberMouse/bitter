class User < ActiveRecord::Base
  # Remember to create a migration!
  def self.authenticate(user_name, password)
    if User.exists?(user_name: user_name)
      user = User.find_by_user_name(user_name)
      if user.password == password
        user
      end
    else
      nil
    end
  end
end
