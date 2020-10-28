Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #


  resource :payment_calendar, only: :show do
    resources :payment_schedules, only: [:create, :update, :destroy]
  end
  get "cash-flow", to: "payment_callendars#cash_flow"

  get "quick-balance", to: "payment_callendars#quick_balance"

  get "duplicate-transactions", to: "payment_callendars#duplicate_transactions"

  root to: "payment_callendars#cash_flow"
end
