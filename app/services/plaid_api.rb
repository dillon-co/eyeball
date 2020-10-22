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

    def transactions(access_token, time_ago=1.week.ago)
      transaction_response =  client.transactions.get(access_token,
                                                      time_ago.strftime("%Y-%m-%d"),
                                                      Date.today.strftime("%Y-%m-%d"),
                                                      count: 500)
      transactions = transaction_response.transactions
      transactions.as_json
    end

    def transactions_by_month(access_token, month_selected=1.month.ago)
      start_date, end_date = month_selected.beginning_of_month, month_selected.end_of_month
      transaction_response =  client.transactions.get(access_token,
                                                      start_date.strftime("%Y-%m-%d"),
                                                      end_date.strftime("%Y-%m-%d"),
                                                      count: 500)
      transactions = transaction_response.transactions
      transactions.as_json
    end

    def get_transactions_per_month(access_token, num_months_back=4)
      counter = 0
      all_transactions = []
      while counter < num_months_back
        all_transactions << transactions(access_token, counter.months.ago)
        counter +=1
      end
      all_transactions
    end

    def balance(access_token)
      client.accounts.balance.get(access_token)
    end
  end
end
