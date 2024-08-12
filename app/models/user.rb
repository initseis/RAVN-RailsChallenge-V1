# frozen_string_literal: true

class User < ApplicationRecord
  include Filterable

  INACTIVITY_THRESHOLD = 1.week
  DEFAULT_IMAGE_URL = '/images/default_avatar.png'

  devise :database_authenticatable, :recoverable, :rememberable
  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_fill: [256, 256], preprocessed: true
  end

  has_many :user_pokemons, dependent: :destroy
  has_many :pokemons, through: :user_pokemons
  belongs_to :country
  accepts_nested_attributes_for :user_pokemons, reject_if: :all_blank, allow_destroy: true

  validates :first_name, presence: { allow_blank: false }
  validates :last_name, presence: { allow_blank: false }
  validates :email, presence: { allow_blank: false }, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :username, presence: { allow_blank: true }, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /^[a-zA-Z0-9_.]*$/, multiline: true }
  validates :password, presence: { allow_blank: false }, if: :new_record?

  before_validation :set_username, on: :create
  before_save :delete_pokemons

  enum :role, { trainer: 'trainer', admin: 'admin' }, default: :trainer, validate: true

  search_scope :search, lambda { |text|
                          where('first_name LIKE ?
                                 OR last_name LIKE ?
                                 OR email LIKE ?', "%#{text}%", "%#{text}%", "%#{text}%")
                        }

  attr_writer :login

  def login
    @login || username || email
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def last_pokemon_caught_at
    user_pokemons.last.created_at
  end

  def image_file(size = :small)
    if image.attached?
      image.variant(size)
    elsif image_url.present?
      image_url
    else
      DEFAULT_IMAGE_URL
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  private

  def set_username
    self.username = "#{first_name}_#{Random.hex(4)}" if username.blank?
  end

  def delete_pokemons
    user_pokemons.all.destroy_all unless user_pokemons.all == user_pokemons
  end
end
