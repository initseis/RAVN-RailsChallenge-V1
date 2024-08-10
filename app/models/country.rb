# frozen_string_literal: true

class Country < ApplicationRecord
  ## ASSOCIATIONS ##
  has_many :users, dependent: :destroy

  ## VALIDATIONS ##
  validates :name, presence: { allow_blank: false }, uniqueness: { case_sensitive: false }
end
