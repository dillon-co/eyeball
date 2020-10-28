class PaymentSchedulesController < ApplicationController

  def create
    plaid_item = PlaidItem.find(params[:plaid_item_id])
    payment_schedule = plaid_item.payment_schedules.create(payment_schedule_params)
    if payment_schedule.save
      render json: ["Saved"]
    end
  end

  private

  def payment_schedule_params
    params.require(:payment_schedule).permit(
        :name,
        :description,
        :recurrence_wday,
        :recurrence_type,
        :recurrence_date
        )
  end
end
