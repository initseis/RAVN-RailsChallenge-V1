# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  describe 'validations' do # rubocop:disable Metrics/BlockLength
    let(:country) { Country.create(name: 'Peru') }
    let(:user) do
      User.new(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'p4$$w0rd', country:)
    end

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'it is not valid without a first name' do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it 'it is not valid without a last name' do
      user.last_name = nil
      expect(user).not_to be_valid
    end

    it 'it is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'it is not valid without a country' do
      user.country = nil
      expect(user).not_to be_valid
    end

    it 'it is not valid with a username with invalid characters' do
      user.username = '@john_doe'
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    let(:country) { Country.create(name: 'Peru') }
    let(:user) do
      User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'p4$$w0rd', country:)
    end
    let(:pokemon) do
      Pokemon.create(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                     description: 'A cute electric pokemon')
    end

    it 'belongs to a country' do
      expect(user).to respond_to(:country)
    end

    it 'has many user_pokemons' do
      expect(user).to respond_to(:user_pokemons)
    end

    it 'should destroy user_pokemons when destroyed itself' do
      user.user_pokemons.create(pokemon:)
      expect { user.destroy }.to change { UserPokemon.count }.by(-1)
    end

    it 'has many pokemons through user_pokemons' do
      expect(user).to respond_to(:pokemons)
    end

    it 'can have many pokemons' do
      user.pokemons << pokemon
      expect(user.pokemons).to include(pokemon)
    end
  end

  describe 'methods' do # rubocop:disable Metrics/BlockLength
    let(:country) { Country.create(name: 'Peru') }
    let(:user) do
      User.create(first_name: 'John', last_name: 'Doe', username: 'johndoe', email: 'john@doe.com',
                  password: 'p4$$w0rd', country:)
    end
    let(:pokemon) do
      Pokemon.create(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                     description: 'A cute electric pokemon')
    end

    describe '#login' do
      it 'returns the username if it exists' do
        user.username = 'john_doe'
        expect(user.login).to eq('john_doe')
      end

      it 'returns the email if there is no username' do
        user.username = nil
        expect(user.login).to eq('john@doe.com')
      end

      it 'returns the login attribute if it is set' do
        user.login = 'john_doe'
        expect(user.login).to eq('john_doe')
      end
    end

    describe '#full_name' do
      it 'returns the full name of the user' do
        expect(user.full_name).to eq('John Doe')
      end
    end

    describe '#last_pokemon_caught_at' do
      it 'returns the date of the last pokemon caught' do
        user.pokemons << pokemon
        expect(user.last_pokemon_caught_at).to eq(user.user_pokemons.last.created_at)
      end
    end

    describe '#image_file' do
      it 'returns the image variant if it is attached' do
        user.image.attach(io: File.open('public/images/default_avatar.png'), filename: 'avatar.png')
        expect(user.image_file).to be_instance_of(ActiveStorage::VariantWithRecord)
      end

      it 'returns the image_url if it is present' do
        user.image_url = 'http://example.com/avatar.jpg'
        expect(user.image_file).to eq('http://example.com/avatar.jpg')
      end

      it 'returns the default image if no image is attached or url is present' do
        expect(user.image_file).to eq(User::DEFAULT_IMAGE_URL)
      end
    end
  end
end
