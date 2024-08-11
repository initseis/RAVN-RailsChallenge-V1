# frozen_string_literal: true

require 'open-uri'

class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[show edit update destroy]
  def index
    pokemons = (current_user.admin? ? Pokemon.all : current_user.pokemons).filterr(filter_params)
    @pagy, @pokemons = pagy(pokemons)
  end

  def show; end

  def new
    @pokemon = Pokemon.new
    authorize @pokemon
    @pokemon.pokemon_countries.build
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      render turbo_stream: turbo_stream.action(:redirect, pokemons_path)
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @pokemon }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def edit
    authorize @pokemon
  end

  def update
    authorize @pokemon
    if @pokemon.update(pokemon_params)
      render turbo_stream: turbo_stream.action(:redirect, pokemons_path)
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @pokemon }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize @pokemon
    @pokemon.destroy
    render turbo_stream: turbo_stream.action(:redirect, pokemons_path)
  end

  private

  def filter_params
    params.permit(:search)
  end
  helper_method :filter_params

  def pokemon_params
    params.require(:pokemon)
          .permit(:name, :main_technique, :country_id, :pokemon_type, :description,
                  pokemon_countries_attributes: %i[country_id _destroy])
          .merge(image: params[:pokemon][:image], image_url: params[:pokemon][:image_url])
  end

  def set_pokemon
    @pokemon = Pokemon.find_by(id: params[:id])
  end
end
