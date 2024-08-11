# frozen_string_literal: true

class User < ApplicationRecord
  include Filterable

  devise :database_authenticatable, :recoverable, :rememberable
  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_fill: [256, 256], preprocessed: true
  end

  has_many :user_pokemons, dependent: :destroy
  belongs_to :country
  accepts_nested_attributes_for :user_pokemons, reject_if: :all_blank, allow_destroy: true

  validates :first_name, presence: { allow_blank: true }
  validates :last_name, presence: { allow_blank: true }
  validates :email, presence: { allow_blank: false }, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :username, presence: { allow_blank: true }, uniqueness: { case_sensitive: false }, if: :admin?

  before_validation :delete_duplicated_pokemon_countries

  enum :role, { trainer: 'trainer', admin: 'admin' }, default: :trainer, validate: true

  search_scope :search, lambda { |text|
                          where('first_name LIKE ?
                                 OR last_name LIKE ?
                                 OR email LIKE ?', "%#{text}%", "%#{text}%", "%#{text}%")
                        }

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def pokemons_names
    user_pokemons.includes(:pokemon).pluck(:name).to_sentence
  end

  private

  def delete_duplicated_pokemon_countries
    user_pokemons.all.destroy_all
    user_pokemons.group_by(&:pokemon_id).each_value do |duplicates|
      duplicates.shift
      duplicates.each(&:destroy)
    end
  end
end
