# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

 User.create([{
     name: Faker::TvShows::RickAndMorty.character,
     photo: Faker::Avatar.image,
     email: 'pep@mail.com',
     password: '123456',
     password_confirmation: '123456'
 },{
     name: Faker::TvShows::RickAndMorty.character,
     photo: Faker::Avatar.image,
     email: 'pip@mail.com',
     password: '123456',
     password_confirmation: '123456'
 },{
     name: Faker::TvShows::RickAndMorty.character,
     photo: Faker::Avatar.image,
     email: 'pop@mail.com',
     password: '123456',
     password_confirmation: '123456'
 },{
     name: Faker::TvShows::RickAndMorty.character,
     photo: Faker::Avatar.image,
     email: 'pap@mail.com',
     password: '123456',
     password_confirmation: '123456'
 },{
     name: Faker::TvShows::RickAndMorty.character,
     photo: Faker::Avatar.image,
     email: 'pup@mail.com',
     password: '123456',
     password_confirmation: '123456'
 }])

 50.times do
     Tweet.create(
         content: Faker::TvShows::RickAndMorty.quote,
         user_id: Random.rand(1..5)
     )
 end

AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?