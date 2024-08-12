# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do # rubocop:disable Metrics/BlockLength
  describe 'validations' do # rubocop:disable Metrics/BlockLength
    let(:pokemon) do
      Pokemon.new(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                  description: 'A cute electric pokemon')
    end

    it 'is valid with valid attributes' do
      expect(pokemon).to be_valid
    end

    it 'it is not valid without a name' do
      pokemon.name = nil
      expect(pokemon).not_to be_valid
    end

    it 'it is not valid without a pokemon type' do
      pokemon.pokemon_type = nil
      expect(pokemon).not_to be_valid
    end

    it 'it is not valid with an invalid pokemon type' do
      pokemon.pokemon_type = :invalid
      expect(pokemon).not_to be_valid
    end

    it 'it is not valid without a main technique' do
      pokemon.main_technique = nil
      expect(pokemon).not_to be_valid
    end

    it 'it is not valid without a description' do
      pokemon.description = nil
      expect(pokemon).not_to be_valid
    end
  end

  describe 'associations' do
    let(:pokemon) do
      Pokemon.create(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                     description: 'A cute electric pokemon')
    end

    it 'has many pokemon_countries' do
      expect(pokemon).to respond_to(:pokemon_countries)
    end

    it 'should destroy pokemon_countries when destroyed itself' do
      pokemon.pokemon_countries.create(country: Country.create(name: 'Peru'))
      expect { pokemon.destroy }.to change { PokemonCountry.count }.by(-1)
    end

    it 'has many user_pokemons' do
      expect(pokemon).to respond_to(:user_pokemons)
    end

    it 'should destroy user_pokemons when destroyed itself' do
      pokemon.user_pokemons.create(user: User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                                     password: 'p4$$w0rd', country: Country.create(name: 'Peru')))
      expect { pokemon.destroy }.to change { UserPokemon.count }.by(-1)
    end
  end

  describe 'methods' do
    let(:pokemon) do
      Pokemon.create(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                     description: 'A cute electric pokemon')
    end
    let(:country) { Country.create(name: 'Peru') }

    describe '#countries_names' do
      it 'returns the names of the countries where the pokemon is found' do
        pokemon.pokemon_countries.create(country:)
        expect(pokemon.countries_names).to eq('Peru')
      end
    end

    describe '#image_file' do
      it 'returns the image variant if it is attached' do
        pokemon.image.attach(io: File.open('public/images/default_pokemon.png'), filename: 'pokemon.png')
        expect(pokemon.image_file).to be_instance_of(ActiveStorage::VariantWithRecord)
      end

      it 'returns the image_url if it is present' do
        pokemon.image_url = 'http://example.com/pokemon.jpg'
        expect(pokemon.image_file).to eq('http://example.com/pokemon.jpg')
      end

      it 'returns the default image if no image is attached or url is present' do
        expect(pokemon.image_file).to eq(Pokemon::DEFAULT_POKEMON_IMAGE_URL)
      end
    end
  end
end
