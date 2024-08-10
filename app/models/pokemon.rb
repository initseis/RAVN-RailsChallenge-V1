# frozen_string_literal: true

class Pokemon < ApplicationRecord
  include Filterable

  ## ASSOCIATIONS ##
  belongs_to :user

  ## VALIDATIONS ##
  validates :name, presence: { allow_blank: false }
  validates :main_technique, presence: { allow_blank: false }
  validates :description, presence: { allow_blank: false }

  ## ENUMS ##
  enum :pokemon_type, { fire: 'fire', water: 'water', grass: 'grass', electric: 'electric' }, default: :fire,
                                                                                              validate: true

  ## SCOPES ##
  search_scope :name_or_type, ->(text) { where('name LIKE ? OR pokemon_type LIKE ?', "%#{text}%", "%#{text}%") }
end
