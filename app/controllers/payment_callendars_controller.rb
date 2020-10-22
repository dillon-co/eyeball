class PaymentCallendarsController < ApplicationController

  def quick_balance
    PlaidItem.last.quick_balance
  end

  def cash_flow
    cash_flow = PlaidItem.last.daily_and_weekly_spend
    render json: cash_flow
  end
end
