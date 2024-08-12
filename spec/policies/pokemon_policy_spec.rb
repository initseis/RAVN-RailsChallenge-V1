# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonPolicy, type: :model do # rubocop:disable Metrics/BlockLength
  let(:admin) do
    User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'p4$$w0rd', role: :admin,
                country: Country.create(name: 'Peru'))
  end
  let(:trainer) do
    User.create(first_name: 'Ash', last_name: 'Ketchum', email: 'ash@ketchum.com', password: 'p4$$w0rd',
                country: Country.create(name: 'Japan'))
  end
  let(:pokemon) do
    Pokemon.create(name: 'Pikachu', pokemon_type: :electric, main_technique: 'Thunderbolt',
                   description: 'A cute electric pokemon')
  end

  subject { described_class }

  it 'allows an admin to create a pokemon' do
    expect(subject.new(admin, pokemon).create?).to be_truthy
  end

  it 'should not allow a trainer to create a pokemon' do
    expect(subject.new(trainer, pokemon).create?).to be_falsy
  end

  it 'allows an admin to update a pokemon' do
    expect(subject.new(admin, pokemon).update?).to be_truthy
  end

  it 'should not allow a trainer to update a pokemon' do
    expect(subject.new(trainer, pokemon).update?).to be_falsy
  end

  it 'allows an admin to destroy a pokemon' do
    expect(subject.new(admin, pokemon).destroy?).to be_truthy
  end

  it 'should not allow a trainer to destroy a pokemon' do
    expect(subject.new(trainer, pokemon).destroy?).to be_falsy
  end
end
