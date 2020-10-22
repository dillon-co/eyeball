# == Schema Information
#
# Table name: payment_groups
#
#  id :integer          not null, primary key
#

class PaymentGroup < ApplicationRecord
  has_many :payment_charges
end
