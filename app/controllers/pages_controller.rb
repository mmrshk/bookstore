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

    @account_info = Net::HTTP.post_form(URI.parse("https://#{@account}.joinposter.com/api/v2/auth/access_token"),
                                        params_for_request)
    @access_token = JSON.parse(@account_info.body)['access_token']
    @waiters = JSON.parse(Net::HTTP.get_response(URI.parse("https://joinposter.com/api/access.getEmployees?token=#{@access_token}")))
  end

  private

  def set_account
    @account = params[:account]
  end
end
