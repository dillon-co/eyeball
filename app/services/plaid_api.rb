# https://github.com/plaid/plaid-ruby
class PlaidApi
  include HTTParty
  base_uri "https://#{ENV['PLAID_ENV']}.plaid.com"
  headers "Content-Type" => "application/json"

  # ========== Retrieving access_token
  # git clone https://github.com/plaid/quickstart.git
  # cd quickstart/ruby
  # bundle
  # PLAID_CLIENT_ID='***' \
  # PLAID_SECRET='***' \
  # PLAID_PUBLIC_KEY='***' \
  # PLAID_ENV='development' \
  # PLAID_PRODUCTS='transactions' \
  # PLAID_COUNTRY_CODES='US' \
  # ruby app.rb
  # -- Visit `http://localhost:4567`
  # -- Follow steps on page

  class << self
    def client
      @client ||= Plaid::Client.new(
          env:        ENV['PLAID_ENV'],
          client_id:  ENV['PLAID_CLIENT_ID'],
          secret:     ENV['PLAID_DEVELOPMENT_SECRET'],
          # public_key: ENV['PLAID_PUBLIC_KEY']
      )
    end

    def transactions(access_token, start_date=1.month.ago, end_date=DateTime.now)
      client.transactions.get(access_token, start_date.strftime("%Y-%m-%d"), end_date.strftime("%Y-%m-%d")).as_json
    end

    def balance(access_token)
      client.accounts.balance.get(access_token)
    end
  end
end
