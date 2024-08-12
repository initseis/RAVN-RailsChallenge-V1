# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrainerPolicy, type: :model do # rubocop:disable Metrics/BlockLength
  let(:admin) do
    User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'p4$$w0rd', role: :admin,
                country: Country.create(name: 'Peru'))
  end
  let(:trainer) do
    User.create(first_name: 'Ash', last_name: 'Ketchum', email: 'ash@ketchum.com', password: 'p4$$w0rd',
                country: Country.create(name: 'Japan'))
  end

  subject { described_class }

  it 'allows an admin to see all trainers' do
    expect(subject.new(admin, trainer).index?).to be_truthy
  end

  it 'should not allow a trainer to see all trainers' do
    expect(subject.new(trainer, trainer).index?).to be_falsy
  end

  it 'allows an admin to see a trainer' do
    expect(subject.new(admin, trainer).show?).to be_truthy
  end

  it 'should allow a trainer to see itself' do
    expect(subject.new(trainer, trainer).show?).to be_truthy
  end

  it 'allows an admin to create a trainer' do
    expect(subject.new(admin, trainer).create?).to be_truthy
  end

  it 'should not allow a trainer to create a trainer' do
    expect(subject.new(trainer, trainer).create?).to be_falsy
  end

  it 'allows an admin to update a trainer' do
    expect(subject.new(admin, trainer).update?).to be_truthy
  end

  it 'should not allow a trainer to update a trainer' do
    expect(subject.new(trainer, trainer).update?).to be_falsy
  end

  it 'allows an admin to destroy a trainer' do
    expect(subject.new(admin, trainer).destroy?).to be_truthy
  end

  it 'should not allow a trainer to destroy a trainer' do
    expect(subject.new(trainer, trainer).destroy?).to be_falsy
  end
end
