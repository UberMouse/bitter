class User < ActiveRecord::Base
  has_many :tweets

  def add_stalker(user)
    Stalker.create(user_id: id, stalker_id: user.id)
  end

  def add_honcho(user)
    Honcho.create(user_id: id, honcho_id: user.id)
  end

  def stalkers
    stalkers = Stalker.where(user_id: id)
    stalkers.map do |stalker|
      User.find(stalker.stalker_id)
    end
  end

  def honchos
    honchos = Honcho.where(user_id: id)
    honchos.map do |honcho|
      User.find(honcho.honcho_id)
    end
  end

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
