# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  fullname: "Admin",
  email: "admin@gmail.com",
  role: 1,
  password: "123456",
  password_confirmation: "123456"
)

User.create!(
  fullname: "Ai Cũng được",
  email: "ai@gmail.com",
  password: "654321",
  password_confirmation: "654321")
  5.times do |n|
    fullname = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password = "111111"
    password_confirmation = "111111"
    User.create!(
      fullname: fullname,
      email: email,
      role: 0,
      password: password,
      password_confirmation: password
    )
  end
