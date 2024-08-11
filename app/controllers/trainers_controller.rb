# frozen_string_literal: true

require 'open-uri'

class TrainersController < ApplicationController
  before_action :set_trainer, only: %i[show edit update destroy]
  def index
    authorize :trainer, :index?
    @trainers = User.trainer.filterr(filter_params)
  end

  def show
    # authorize [:trainer, current_user], :show?
    redirect_to root_path unless TrainerPolicy.new(current_user, @trainer).show?
  end

  def new
    @trainer = User.new
    authorize :trainer, :new?
    @trainer.user_pokemons.build
  end

  def create
    @trainer = User.new(trainer_params.merge(password: SecureRandom.hex(8)))
    authorize :trainer, :create?
    if @trainer.save
      redirect_to trainers_path
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @trainer }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def edit
    authorize :trainer, :edit?
  end

  def update
    authorize :trainer, :update?
    if @trainer.update(trainer_params)
      redirect_to trainers_path
    else
      render turbo_stream: turbo_stream.update(:form_errors, partial: 'shared/form_errors', locals: { object: @trainer }), # rubocop:disable Layout/LineLength
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize :trainer, :destroy?
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
          .merge(image: params[:trainer][:image], image_url: params[:trainer][:image_url])
  end

  def set_trainer
    @trainer = User.find_by(id: params[:id])
  end
end
