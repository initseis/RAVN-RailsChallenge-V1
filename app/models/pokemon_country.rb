# frozen_string_literal: true

class PokemonCountry < ApplicationRecord
  belongs_to :pokemon
  belongs_to :country
end
