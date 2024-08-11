# frozen_string_literal: true

class InactivityReminderJob < ApplicationJob
  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    return if user.last_pokemon_caught_at + User::INACTIVITY_THRESHOLD >= scheduled_at

    UserMailer.inactivity_reminder(user_id).deliver_now
  end
end
