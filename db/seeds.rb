# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(email: 'admin@admin.com', password: 'admin@admin.com', password_confirmation: 'admin@admin.com')

# user = User.new(
#     email: "admin@example.com",
#     password: "admin@example.com",
#     password_confirmation: "admin@example.com"
# )
# user.skip_confirmation!
# user.save!
PublicActivity.enabled = false
30.times do 
    Course.create!([{
        title: Faker::Educator.course_name,
        description: Faker::TvShows::GameOfThrones.quote,
        user_id: User.first.id,
        short_description: Faker::Quote.famous_last_words,
        language: Faker::ProgrammingLanguage.name,
        level: "beginner",
        price: Faker::Number.between(from: 1000, to: 20000)
    }])
end
PublicActivity.enabled = true