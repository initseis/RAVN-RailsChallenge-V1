# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :pokemon_countries, dependent: :destroy

  validates :name, presence: { allow_blank: false }, uniqueness: { case_sensitive: false }
end
