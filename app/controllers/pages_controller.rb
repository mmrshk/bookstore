require "uri"
require "net/http"

class PagesController < ApplicationController
  authorize_resource class: false
  before_action :set_account

  def home
    params_for_request = {
      'application_id'        => 925,
      'application_secret'    => '7979da75e3ed229483d0a288bee86e5d',
      'grant_type'            => 'authorization_code',
      'redirect_uri'          => 'https://radiant-plains-48256.herokuapp.com',
      'code'                  => params[:code]
    }

    a = Net::HTTP.post_form(URI.parse('https://api-demo.joinposter.com/api/v2/auth/access_token'), params_for_request)
    @account_info = a.body
  end

  private

  def set_account
    @account = params[:account]
  end
end
