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
