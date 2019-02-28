class Ability
  include CanCan::Ability

  def initialize(user, session)
    user ||= User.new

    can :read, :all
    can [:home], :page
    if user.admin?
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :create, Review, user_id: user.id
      can :create, LineItem
      can [:show, :update], :checkout
      can %i[read create update], [Order, Address, CreditCard], user_id: user.id
      can %i[update destroy], LineItem, id: session[:line_item_ids].to_a
      can :manage, User, id: user.id
    else
      can :create, LineItem
      can %i[update destroy], LineItem, id: session[:line_item_ids].to_a
      cannot :read, [Order, CreditCard, Address]
    end
  end
end
