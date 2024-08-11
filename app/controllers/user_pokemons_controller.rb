# frozen_string_literal: true

class UserPokemonsController < ApplicationController
  def new
    @user_pokemon = UserPokemon.new
  end

  def create # rubocop:disable Metrics/AbcSize
    @user_pokemon = UserPokemon.new(user_pokemon_params.merge(user: current_user))
    if @user_pokemon.save
      PokemonMailer.pokemon_added(@user_pokemon.id).deliver_later
      InactivityReminderJob.set(wait_until: @user_pokemon.created_at + User::INACTIVITY_THRESHOLD)
                           .perform_later(current_user.id)
      render turbo_stream: turbo_stream.action(:redirect, trainer_path(current_user))
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @user_pokemon }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  private

  def user_pokemon_params
    params.require(:user_pokemon).permit(:pokemon_id, :alias)
  end
end
