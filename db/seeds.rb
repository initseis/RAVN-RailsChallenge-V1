# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Country.create!(name: 'Kanto')
Country.create!(name: 'Johto')
Country.create!(name: 'Hoenn')
User.create!(first_name: 'Sam', last_name: 'Sepiol', email: 'sam@gmail.com', username: 'initseis',
             password: 'k234234234', country: Country.first, role: :admin)
User.create!(first_name: 'Ash', last_name: 'Ketchum', email: 'ash@gmail.com', password: 'k234234234',
             country: Country.first, role: :trainer)
User.create!(first_name: 'Misty', last_name: 'Waterflower', email: 'misty@gmail.com', password: 'k234234234',
             country: Country.second, role: :trainer)
User.create!(first_name: 'Brock', last_name: 'Harrison', email: 'brock@gmail.com', password: 'k234234234',
             country: Country.third, role: :trainer)
Pokemon.create!(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                description: 'A cute electric pokemon')
Pokemon.create!(name: 'Charmander', pokemon_type: :fire, main_technique: 'Flamethrower',
                description: 'A cute fire pokemon')
Pokemon.create!(name: 'Squirtle', pokemon_type: :water, main_technique: 'Water Gun',
                description: 'A cute water pokemon')
