# frozen_string_literal: true

class PokemonCountry < ApplicationRecord
  include Filterable

  belongs_to :pokemon
  belongs_to :country
end
