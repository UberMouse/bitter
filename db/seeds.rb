require 'faker'

10.times do
  new_user = User.create(name: Faker::Name.name,
                        user_name: Faker::Internet.user_name,
                        email: Faker::Internet.email,
                        password: "password")
end

stalker = User.create(name: Faker::Name.name,
                        user_name: Faker::Internet.user_name,
                        email: Faker::Internet.email,
                        password: "password")

honcho = User.create(name: Faker::Name.name,
                        user_name: Faker::Internet.user_name,
                        email: Faker::Internet.email,
                        password: "password")
10.times do
  new_tweet = Tweet.create(text: Faker::Company.bs, user_id: rand(13..23))
end

User.all.each do |user|
  user.add_stalker(stalker)
  user.add_honcho(honcho)
end

