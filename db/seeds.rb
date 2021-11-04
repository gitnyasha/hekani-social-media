# Users
# User.create!(
#   email: "user@mail.org.zw",
#   password: "123456",
#   password_confirmation: "123456",
# )

# 9.times do |n|
#   email = "user#{n + 1}@mail.org.zw"
#   password = "password"
#   User.create!(
#     email: email,
#     password: password,
#     password_confirmation: password,
#   )
# end

# # Create following relationships.
# users = User.all
# user = users.first
# following = users[2..5]
# followers = users[3..4]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }

# articles
users = User.all
5.times do
  title = "Tech"
  users.each { |user|
    # user.articles.create!(title: title, link: "https://zimtechdaily.co.zw/buy-the-galanz-retro-bottom-mount-refrigerator-for-689-99-on-amazon/")
    user.questions.create!(title: title)
  }
end
