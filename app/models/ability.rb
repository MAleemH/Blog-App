class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    # Define abilities for different user roles
    if user.role == "admin"
      can :manage, :all
    else
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
    end
  end
end
