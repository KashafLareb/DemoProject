# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
      else
        can :read, Article
        can :read, Category
        can :destroy, Comment, user: user
      end
    end
  end
end
