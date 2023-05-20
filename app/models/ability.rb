class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    # Define abilities for different user roles
    if user.role == 'admin'
      can :manage, :all
    else
      can :destroy, Post, author: user
      can :destroy, Comment, author: user
    end
  end
end
