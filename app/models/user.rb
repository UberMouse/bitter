class User < ActiveRecord::Base
  has_many :tweets

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
