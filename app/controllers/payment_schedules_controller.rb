class PaymentSchedulesController < ApplicationController

  def create
    plaid_item = PlaidItem.first
    payment_schedule = payment_schedule_params.transform_keys { |k| k.underscore }
    payment_schedule["amount"] *= 100
    payment_schedule["amount_in_pennies"] = payment_schedule.delete "amount"
    payment_schedule = plaid_item.payment_schedules.create(payment_schedule)
    if payment_schedule.save
      render json: ["Saved"]
    end
  end

  private

  def payment_schedule_params
    params.require(:payment_schedule).permit(
        :name,
        :amount,
        :description,
        :recurrenceWday,
        :recurrenceType,
        :recurrenceDate
        )
  end
end
