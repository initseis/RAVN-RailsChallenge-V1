# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    pokemons_path
  end
end
