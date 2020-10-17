class PaymentCharge < ApplicationRecord
  belongs_to :payment_category, optional: true
  belongs_to :payment_group
end
