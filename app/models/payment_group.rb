class PaymentGroup < ApplicationRecord
  has_many :payment_charges
end
