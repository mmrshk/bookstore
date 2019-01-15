class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    if user.admin?
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :create, Review, user_id: user.id
      can %i[create update], Address, addressable_type: 'User', addressable_id: user.id
      can %i[create update], [Order, CreditCard], user_id: user.id
      can %i[create update destroy], LineItem
      #can %i[update destroy], LineItem, id: session[:book_id].to_a
      can :manage, User, id: user.id
    else
      can %i[create update destroy], LineItem
      #can %i[update destroy], LineItem, id: session[:book_id].to_a
    end
  end
end
