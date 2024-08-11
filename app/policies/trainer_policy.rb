# frozen_string_literal: true

class TrainerPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user == trainer
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  private

  def trainer
    @trainer ||= record
  end
end
