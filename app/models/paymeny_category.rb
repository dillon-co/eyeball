class PaymentCategory < ApplicationRecord
  has_many :payment_charges
end
