# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def inactivity_reminder(user_id)
    @user = User.find_by(id: user_id)

    mail(to: @user.email, subject: 'You have not caught any pokemon in a while!')
  end
end
