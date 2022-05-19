# Users
100.times do |n|
  email = "user#{n + 1}@main.com"
  password = "12345678"
  User.create!(
    name: Faker::Name.name,
    bio: Faker::Lorem.sentence,
    image: Faker::LoremFlickr.image,
    birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    email: email,
    password: password,
    password_confirmation: password,
  )
end

# Create following relationships.
User.all.each do |user|
  following = User.all.sample(10)
  following.each do |followed|
    user.follow(followed)
  end
  question_category = Faker::ProgrammingLanguage.name
  title = Faker::Lorem.question
  answer = Faker::Lorem.paragraph
  category = QuestionCategory.create!(name: question_category)
  user.questions.create!(title: title, question_category_id: category.id)
  user.answers.create!(title: answer, question_id: user.questions.last.id)

  article_category = Faker::ProgrammingLanguage.name
  title = Faker::Lorem.sentence
  link = Faker::Internet.url
  image = Faker::LoremFlickr.image
  category = ArticleCategory.create!(name: article_category)
  user.articles.create!(title: title, link: link, image: image, article_category_id: category.id)
end

# create comments to answers
User.all.each do |user|
  user.answers.each do |answer|
    comment = Faker::Lorem.sentence
    user.comments.create!(title: comment, answer_id: answer.id)
  end
end

# create replies to articles
User.all.each do |user|
  user.articles.each do |article|
    comment = Faker::Lorem.sentence
    user.replies.create!(title: comment, article_id: article.id)
  end
end

# vote answers
User.all.each do |user|
  user.answers.each do |answer|
    user.votes.create!(answer_id: answer.id)
  end
end

# like articles
User.all.each do |user|
  user.articles.each do |article|
    user.likes.create!(article_id: article.id)
  end
end

# user follow article categories
User.all.each do |user|
  article_categories = ArticleCategory.all
  article_categories.each do |article_category|
    user.follow_articles(article_category)
  end
end

# user follow question categories
User.all.each do |user|
  question_categories = QuestionCategory.all
  question_categories.each do |question_category|
    user.follow_questions(question_category)
  end
end
