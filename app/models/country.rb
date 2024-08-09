class Country < ApplicationRecord
  ## ASSOCIATIONS ##
  has_many :users

  ## VALIDATIONS ##
  validates :name, presence: { allow_blank: false }, uniqueness: { case_sensitive: false }
end
