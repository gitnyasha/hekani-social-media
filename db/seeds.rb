require "faker"

# Users
User.create!(
  email: "example@hekani.org.zw",
  password: "123456",
  password_confirmation: "123456",
)

9.times do |n|
  email = "example-#{n + 1}@hekani.org.zw"
  password = "password"
  User.create!(
    email: email,
    password: password,
    password_confirmation: password,
  )
end

# Create following relationships.
users = User.all
user = users.first
following = users[2..5]
followers = users[3..4]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# articles
users = User.all
5.times do
  title = "This my title"
  users.each { |user|
    user.articles.create!(title: title, link: "http://localhost:3001")
    user.questions.create!(title: title)
  }
end
