# == Schema Information
#
# Table name: plaid_items
#
#  id                      :bigint           not null, primary key
#  bank_name               :string
#  plaid_item_id           :text
#  plaid_item_access_token :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class PlaidItem < ApplicationRecord
  def balance
    return unless plaid_item_access_token
    ## TODO
    @balance ||= Rails.cache.fetch("plaid_item_#{id}_quick_balance", expires_in: 12.hours) do
      PlaidApi.balance(plaid_item_access_token)
    end
  end

  def transactions(time_ago=1.week.ago)
    return unless plaid_item_access_token
    @transactions ||= Rails.cache.fetch("plaid_item_#{id}_transactions", expires_in: 12.hours) do
      PlaidApi.transactions(plaid_item_access_token, time_ago)
    end
  end

  def past_transactions
    TransactionService.past_payments(transactions)
  end

  def duplicate_transactions
    transactions_by_month = PlaidApi.get_transactions_per_month(plaid_item_access_token)
    puts "#{transactions_by_month.flatten.count} Transactions in the last 4 months"
    TransactionService.get_bills(transactions_by_month)
  end

  def daily_and_weekly_spend
    TransactionService.weekly_and_daily_spend(plaid_item_access_token)
  end

  def quick_balance(account_name=nil)
    if account_name
      accounts = balance["accounts"].find do |account_hash|
        account_hash["name"] == account_name
      end.dig("balance", "current")
    else
      accounts = balance["accounts"].map {|acc| acc.dig("balances", "current")}
    end
    accounts
  end
end
