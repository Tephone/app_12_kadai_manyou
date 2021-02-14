# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "admin",
             email: "admin@example.com",
             password:  "aaaaaa",
             password_confirmation: "aaaaaa",
             admin: true)

9.times do |n|
User.create!(
    email: "tarou#{n + 1}@example.com",
    name: "tarou#{n + 1}",
    password:  "aaaaaa",
    password_confirmation: "aaaaaa" )
end

User.all.each do |user|
    user.tasks.create!(
      title: 'タイトル',
      content: 'テキスト'
    )
end
    
10.times do |i|
    Tag.create!(tag_name: "example#{i + 1}")
end