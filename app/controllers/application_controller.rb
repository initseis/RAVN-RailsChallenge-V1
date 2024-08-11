# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    pokemons_path
  end

  private

  def configure_permitted_parameters
    added_attrs = %i[username email password remember_me]
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
