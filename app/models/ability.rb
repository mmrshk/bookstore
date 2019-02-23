class Ability
  include CanCan::Ability

  def initialize(user, session)
    user ||= User.new

    can :read, :all
    if user.admin?
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :create, Review, user_id: user.id
      can :create, LineItem
      can %i[read create update], [Order, Address, CreditCard, Coupon], user_id: user.id
      can %i[update destroy], LineItem, id: session[:line_item_ids].to_a
      can :manage, User, id: user.id
    else
      can :create, LineItem
      can %i[update destroy], LineItem, id: session[:line_item_ids].to_a
      cannot :read, [Order, CreditCard, Address]
    end
  end
end
