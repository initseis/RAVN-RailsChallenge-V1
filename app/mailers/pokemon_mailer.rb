# frozen_string_literal: true

class PokemonMailer < ApplicationMailer
  def pokemon_added(user_pokemon_id)
    user_pokemon = UserPokemon.find_by(id: user_pokemon_id)
    return unless user_pokemon

    @user = user_pokemon.user
    @pokemon = user_pokemon.pokemon
    mail(to: @user.email, subject: 'You caught a new pokemon!')
  end
end
