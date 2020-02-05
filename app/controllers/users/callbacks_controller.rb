class Users::CallbacksController < ApplicationController
  def facebook
    sign_in_and_redirect User.from_omniauth(request.env['omniauth.auth'])
  end

  def failure
    redirect_to root_path
  end
end
