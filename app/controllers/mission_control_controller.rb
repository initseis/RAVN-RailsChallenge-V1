# frozen_string_literal: true

class MissionControlController < ApplicationController
  skip_before_action :authenticate_user!
  http_basic_authenticate_with name: ENV['MISSION_CONTROL_USER'],
                               password: ENV['MISSION_CONTROL_PASSWORD']
end
