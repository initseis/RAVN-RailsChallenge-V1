# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
