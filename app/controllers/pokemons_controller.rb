# frozen_string_literal: true

require 'open-uri'

class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[show edit update destroy]
  def index
    @pokemons = current_user.pokemons.filterr(filter_params)
  end

  def show; end

  def new
    @pokemon = Pokemon.new
    @pokemon.image = nil
  end

  def create
    # @pokemon = Pokemons::CreatorService.new(pokemon_params).call
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      redirect_to pokemons_path
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @pokemon }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    # @pokemon = Pokemons::UpdaterService.new(@pokemon, pokemon_params).call
    if @pokemon.update(pokemon_params)
      redirect_to pokemons_path
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @pokemon }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def destroy
    @pokemon.destroy
    redirect_to pokemons_path
  end

  private

  def filter_params
    params.permit(:name_or_type)
  end

  def pokemon_params
    params.require(:pokemon)
          .permit(:name, :main_technique, :country_id, :pokemon_type, :description,
                  pokemon_countries_attributes: %i[country_id _destroy])
          .merge(user: current_user)
          .merge(image: params[:pokemon][:image])
          .merge(image_url: params[:pokemon][:image_url])
  end

  def set_pokemon
    @pokemon = current_user.pokemons.find_by(id: params[:id])
  end
end
