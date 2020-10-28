class PaymentCallendarsController < ApplicationController

  #TODO fix typo in class name

  def quick_balance
    render json: PlaidItem.last.quick_balance
  end

  def cash_flow
    cash_flow = PlaidItem.last.daily_and_weekly_spend
    render json: cash_flow
  end

  def recurring_transactions
    PlaidItem.last.recurring_transactions
  end

  def duplicate_transactions
    render json: PlaidItem.last.duplicate_transactions
  end
end
