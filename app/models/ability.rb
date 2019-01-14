class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :read, [Author, Book, Category, Coupon, Delivery, Cart]
      can :read, Review
      can :create, Review, user_id: user.id
      can %i[read create update], [Order, Address, CreditCard], user_id: user.id
      can :create, LineItem
      #can %i[update destroy], LineItem, id: session[:book_id].to_a
      can :manage, User, id: user.id
    else
      can :read, [Author, Book, Category, Review, Cart]
      can :create, LineItem
      #can %i[update destroy], LineItem, id: session[:book_id].to_a
    end
  end
end
