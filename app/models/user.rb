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

  def get_honcho_tweets
    honcho_tweets = honchos.map{|h| h.tweets}.flatten

    tweets = []
    until tweets.length == [honcho_tweets.length-1, 30].min
      tweet = honcho_tweets.sample
      tweet_deets = tweet.get_presentation_deets
      tweets << tweet_deets unless tweets.include? tweet_deets
    end
    tweets
  end

  def gravatar_url
    gravatar_hash = Digest::MD5.hexdigest(email.chomp.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_hash}?s=64&d=mm"
  end
end
