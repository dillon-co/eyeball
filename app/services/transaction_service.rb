class TransactionService

  class << self
    def past_payments(transactions)
      transactions.flatten
    end

    def charges_less_than(transactions, limit=20)
      get_past_payments(transactions).select do  |t|
        t['amount'] < limit
      end
    end

    def find_by_category(category, transactions)
      past_payments(transactions).select {|t| t['category'].include?(category.titleize)}
    end

    def occurence(transactions, selector)
      charges = charges_less_than(transactions, 100).map{|t| t[selector]}.flatten
      places = charges.uniq
      places.map {|place| [place, charges.count(place)]}
    end

    def pretty_print_sorted_occurance(transactions, selector)
      pp occureence(transactions, selector).sort_by { |o| o[1] }
    end

    def sort_amount(transaction_arr)
      transaction_arr.sort_by {|t| t['amount']}
    end

    def get_bills(transactions)
      recurring_transactions.map do |t|
        past_payments.select{|tt| tt.slice("amount", "merchant_name") == t}.first
      end
    end

    def searchable_transactions(transactions)
      transactions.map {|m| m.map {|s| s.slice("amount", "merchant_name") } }
    end

    def recurring_transactions(transactions)
      bills = []
      searchable_transactions(transactions).each_with_index do |month, i|
        searchable_transactions(transactions).each_with_index do |outer_month, ind|
          unless ind == i
            month.each do |transaction|
              if outer_month.include? transaction
                bills << transaction
              end
            end
          end
        end
      end
      bills.uniq!
    end

    def weekly_and_daily_spend(access_token)
      yesterday = PlaidApi.transactions(access_token, 2.day.ago)
      last_week = PlaidApi.transactions(access_token)
      {yesterday: positive_and_negative(yesterday), last_week: positive_and_negative(last_week)}
    end

    def positive_and_negative(transactions)
      positive, negative = [], []
      transactions.each do |t|
        t['amount'] > 0 ? negative << t["amount"] :  positive << t["amount"] * -1
      end
      p, n = positive.sum, negative.sum
      {positive: p, negative: n, total: p-n}
    end

  end
end


# {"account_id"=>"VzNrxVmJr8I6Md7zZrXmIAVxmZA5dDtrRAyEE",
#  "amount"=>26,
#  "category"=>["Travel", "Taxi"],
#  "category_id"=>"22016000",
#  "date"=>"2020-10-17",
#  "iso_currency_code"=>"USD",
#  "location"=>{"city"=>"San Francisco", "region"=>"CA"},
#  "merchant_name"=>"Lyft",
#  "name"=>"Lyft",
#  "payment_channel"=>"in store",
#  "payment_meta"=>{},
#  "pending"=>true,
#  "transaction_id"=>"ewN3be0n3ahoKM1YNeDnTAyd8w8KVdFdwqDJK",
#  "transaction_type"=>"special"}
