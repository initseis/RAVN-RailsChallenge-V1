# frozen_string_literal: true

require 'open-uri'

class TrainersController < ApplicationController
  before_action :set_trainer, only: %i[show edit update destroy]
  def index
    @trainers = User.trainer.filterr(filter_params)
  end

  def show; end

  def new
    @trainer = User.new
    @trainer.user_pokemons.build
  end

  def create
    @trainer = User.new(trainer_params)
    if @trainer.save
      redirect_to trainers_path
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @trainer }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @trainer.update(trainer_params)
      redirect_to trainers_path
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @trainer }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def destroy
    @trainer.destroy
    redirect_to trainers_path
  end

  private

  def filter_params
    params.permit(:search)
  end

  def trainer_params
    params.require(:trainer)
          .permit(:first_name, :last_name, :email, :country_id,
                  user_pokemons_attributes: %i[pokemon_id _destroy])
          .merge(image: params[:trainer][:image], image_url: params[:trainer][:image_url],
                 password: SecureRandom.hex(8))
  end

  def set_trainer
    @trainer = User.find_by(id: params[:id])
  end
end
