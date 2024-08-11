# frozen_string_literal: true

class Pokemon < ApplicationRecord
  include Filterable

  belongs_to :user
  has_many :pokemon_countries, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_fill: [256, 256], preprocessed: true
  end
  accepts_nested_attributes_for :pokemon_countries, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: { allow_blank: false }
  validates :main_technique, presence: { allow_blank: false }
  validates :description, presence: { allow_blank: false }

  before_validation :delete_duplicated_pokemon_countries

  enum :pokemon_type, { fire: 'fire', water: 'water', grass: 'grass', electric: 'electric' }, default: :fire,
                                                                                              validate: true

  search_scope :name_or_type, ->(text) { where('name LIKE ? OR pokemon_type LIKE ?', "%#{text}%", "%#{text}%") }

  def countries_names
    pokemon_countries.includes(:country).pluck(:name).to_sentence
  end

  private

  def delete_duplicated_pokemon_countries
    pokemon_countries.all.destroy_all
    pokemon_countries.group_by(&:country_id).each_value do |duplicates|
      duplicates.shift
      duplicates.each(&:destroy)
    end
  end
end
