class CreateUserPokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :user_pokemons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.string :alias

      t.timestamps
    end
  end
end
