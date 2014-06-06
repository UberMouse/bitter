require 'faker'

100.times do
  User.create(name: Faker::Name.name,
              user_name: Faker::Internet.user_name,
              email: Faker::Internet.email,
              password: "password")
end

User.create(user_name: 'ubermouse', password: '', email: 'ubermouse894@gmail.com')

users = User.all

1500.times do
  users.sample.tweets.create(text: "#{Faker::Company.bs}, #{Faker::Company.bs}, #{Faker::Company.bs}")
end

1000.times do
  begin
    user1 = users.sample
    user2 = users.sample
    if [*1..10].sample > 5
      user1.add_stalker user2
    else
      user1.add_honcho user2
    end
  rescue
  end
end

