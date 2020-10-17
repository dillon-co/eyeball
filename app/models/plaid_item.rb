class PlaidItem < ApplicationRecord
  def balance
    return unless plaid_item_access_token

    @balance ||= Rails.cache.fetch("MACU_quick_balance", expires_in: 12.hours) do
      PlaidApi.balance(plaid_item_access_token)
    end
  end

  def transactions
    return unless plaid_item_access_token
    @balance ||= Rails.cache.fetch("transactions", expires_in: 12.hours) do
      PlaidApi.transactions(plaid_item_access_token)
    end
  end

  def quick_balance(account_name=nil)
    if account_name
      accounts = balance["accounts"].find do |account_hash|
        account_hash["name"] == account_name
      end.dig("balance", "current")
    else
      accounts = balance["accounts"].each {|acc| acc.dig("balances", "current")}
    end
    accounts
  end
end
