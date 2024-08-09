class PokemonsController < ApplicationController
  def index
    @pokemons = current_user.pokemons.filterr(filter_params)
  end

  def new
    @pokemon = Pokemon.new
  end

  private

  def filter_params
    params.permit(:name_or_type)
  end
end
