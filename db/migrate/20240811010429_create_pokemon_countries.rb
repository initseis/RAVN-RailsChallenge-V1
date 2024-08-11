# frozen_string_literal: true

class CreatePokemonCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon_countries do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
