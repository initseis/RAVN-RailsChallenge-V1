# frozen_string_literal: true

class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name, null: false, index: true
      t.string :pokemon_type, null: false, index: true
      t.string :main_technique, null: false
      t.string :image_url
      t.text :description, null: false

      t.timestamps
    end
  end
end
