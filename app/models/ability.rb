class Ability
  include CanCan::Ability

  def initialize(user, session, current_order)
    user ||= User.new

    can :read, :all
    can [:home], :page
    if user.admin?
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :create, Review, user_id: user.id
      can :create, [LineItem, Coupon]
      can %i[show update], :checkout
      can %i[read create update], [Order, CreditCard], user_id: user.id
      can %i[read create update], Address, addressable_id: user.id, addressable_type: 'User'
      can %i[read create update], Address, addressable_id: current_order.id, addressable_type: 'Order'
      can %i[update destroy], LineItem, id: session[:line_item_ids].to_a
      can :manage, User, id: user.id
    else
      can :create, [LineItem, Coupon]
      can %i[update destroy], LineItem, id: session[:line_item_ids].to_a
      cannot :read, [Order, CreditCard, Address]
    end
  end
end
