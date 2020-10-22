# == Schema Information
#
# Table name: payment_categories
#
#  id   :integer          not null, primary key
#  name :string
#

class PaymentCategory < ApplicationRecord
  has_many :payment_charges
end
