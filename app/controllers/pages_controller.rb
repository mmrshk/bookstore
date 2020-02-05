require "uri"
require "net/http"

class PagesController < ApplicationController
  authorize_resource class: false
  before_action :set_account

  UNIQ_PRODUCT_NAME = 'Уникальный продукт'.freeze
  UNIQ_SELLER_COUNT = 5

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
    # @access_token = JSON.parse(@account_info.body)['access_token']
    @access_token = '876245:45107144425ad8d2cb7db71410999824'
    @statistics = JSON.parse(
      Net::HTTP.get_response(URI.parse("https://joinposter.com/api/dash.getWaitersSales?token=#{@access_token}")).body
    )

    @transactions = JSON.parse(
      Net::HTTP.get_response(URI.parse("https://joinposter.com/api/dash.getTransactions?token=#{@access_token}")).body
    )['response']

    @transaction_products = @transactions.map do |transaction|
      a = JSON.parse(
        Net::HTTP.get_response(URI.parse("https://joinposter.com/api/dash.getTransactionProducts?token=#{@access_token}&transaction_id=#{transaction['transaction_id']}")).body
      )['response']
      next unless a.present?

      a.first.merge('transaction_id' => transaction['transaction_id'])
    end.compact.flatten

    # '&dateFrom=20170905'
    # '&dateTo=20170908'

    all_participants = JSON.parse(
      Net::HTTP.get_response(URI.parse("https://joinposter.com/api/access.getEmployees?token=#{@access_token}")).body
    )['response']

    waiters = get_waiters(all_participants)
    waiters = add_default_fields(waiters)
    waiters = add_check_speed_order(waiters, @statistics)
    waiters.first['achievment'] += ['middle_time']
    waiters = add_middle_invoice_order(waiters, @statistics)
    waiters.first['achievment'] += ['middle_invoice']
    waiters = add_count_receipt_order(waiters, @statistics)
    waiters.first['achievment'] += ['clients']
    waiters = add_profit_netto_order(waiters, @statistics)
    @profit_netto_names = waiters.map { |a| [ a['name'] ] }.to_json
    @profit_netto = waiters.map { |a| [ a['profit_netto'].to_i ] }.to_json
    waiters.first['achievment'] += ['profit_netto']
    waiters = add_uniq_product_order(waiters, @transaction_products, @transactions)
    waiters.each do |waiter|
      waiter['achievment'] += ['uniq_product'] if waiter['uniq_product'].to_i == UNIQ_SELLER_COUNT
    end
    waiters = add_guest_serve_order(waiters, @transactions)
    waiters.first['achievment'] += ['guests_count']
    @waiters = waiters.sort_by { |k| k['achievment'].count }.reverse!
    @achievment_names = waiters.map { |a| [ a['name'] ] }.to_json
    @achievments = waiters.map { |a| [ a['achievment'].count ] }.to_json
  end

  private

  def add_default_fields(waiters)
    waiters.each do |waiter|
      waiter['achievment'] = []
      waiter['uniq_product'] = 0
      waiter['guests_count'] = 0
    end
  end

  def get_waiters(all_participants)
    all_participants.delete_if { |participant| participant["role_name"] != 'waiter' }
  end

  def add_check_speed_order(waiters, statistics)
    waiters.each do |a|
      a["middle_time"] = 0.0

      statistics['response'].select do |statistic|
        a["middle_time"] = statistic["middle_time"] if statistic["user_id"].to_i == a["user_id"]
      end
    end

    waiters.sort_by { |k| k['middle_time'].to_i }.reverse!
  end

  def add_middle_invoice_order(waiters, statistics)
    waiters.each do |a|
      a["middle_invoice"] = 0.0

      statistics['response'].select do |statistic|
        a["middle_invoice"] = statistic["middle_invoice"] if statistic["user_id"].to_i == a["user_id"]
      end
    end

    waiters.sort_by { |k| k['middle_invoice'].to_i }.reverse!
  end

  def add_count_receipt_order(waiters, statistics)
    waiters.each do |a|
      a["clients"] = 0

      statistics['response'].select do |statistic|
        a["clients"] = statistic["clients"] if statistic["user_id"].to_i == a["user_id"]
      end
    end

    waiters.sort_by { |k| k['clients'].to_i }.reverse!
  end

  def add_profit_netto_order(waiters, statistics)
    waiters.each do |a|
      a["profit_netto"] = 0

      statistics['response'].select do |statistic|
        a["profit_netto"] = statistic["profit_netto"] if statistic["user_id"].to_i == a["user_id"]
      end
    end

    waiters.sort_by { |k| k['profit_netto'].to_i }.reverse!
  end

  def add_uniq_product_order(waiters, transaction_products, transactions)
    transactions = transactions.map do |a|
      {
        user_id: a['user_id'],
        transaction_id: a['transaction_id']
      }
    end

    transaction_products =  transaction_products.map do |a|
      {
        product_name: a['product_name'],
        transaction_id: a['transaction_id'],
        num: a['num']
      }
    end

    transactions.each do |transaction|
      transaction_products.each do |transaction_product|
        if transaction[:transaction_id] == transaction_product[:transaction_id] && transaction_product[:product_name] == UNIQ_PRODUCT_NAME
           waiters.select { |a| a['user_id'] == transaction[:user_id].to_i }.first['uniq_product'] += transaction_product[:num].to_i
        end
      end
    end

    waiters.sort_by { |k| k['uniq_product'].to_i }.reverse!
  end

  def add_guest_serve_order(waiters, transactions)
    @transactions.each do |transaction|
      waiters.each do |waiter|
        waiter['guests_count'] += transaction['guests_count'].to_i if transaction['user_id'].to_i == waiter['user_id']
      end
    end

    waiters.sort_by { |k| k['guests_count'].to_i }.reverse!
  end

  def set_account
    @account = params[:account]
  end
end
