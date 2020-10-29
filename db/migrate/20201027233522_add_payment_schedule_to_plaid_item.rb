class AddPaymentScheduleToPlaidItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :payment_schedules, :plaid_item, foreign_key: true
  end
end
