class ApplicationController < ActionController::Base
  include Pagy::Backend
  include CurrentCart
  before_action :set_cart

end
