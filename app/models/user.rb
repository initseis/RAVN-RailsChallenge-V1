# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable

  belongs_to :country
  has_many :pokemons, dependent: :destroy

  validates :first_name, presence: { allow_blank: true }
  validates :last_name, presence: { allow_blank: true }
  validates :email, presence: { allow_blank: false }, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :username, presence: { allow_blank: true }, uniqueness: { case_sensitive: false }, if: :admin?

  enum :role, { trainer: 'trainer', admin: 'admin' }, default: :trainer, validate: true
end
