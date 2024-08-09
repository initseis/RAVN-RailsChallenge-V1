class User < ApplicationRecord
  ## GEMS ##
  devise :database_authenticatable, :recoverable, :rememberable

  ## ASSOCIATIONS ##
  belongs_to :country

  ## VALIDATIONS ##
  validates :first_name, presence: { allow_blank: true }
  validates :last_name, presence: { allow_blank: true }
  validates :email, presence: { allow_blank: false }, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :username, presence: { allow_blank: true }, uniqueness: { case_sensitive: false }, if: :admin?

  ## ENUMS ##
  enum :role, { trainer: "trainer", admin: "admin" }, default: :trainer, validate: true
end
