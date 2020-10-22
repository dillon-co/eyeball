# == Schema Information
#
# Table name: plaid_items
#
#  id                      :bigint           not null, primary key
#  bank_name               :string
#  plaid_item_id           :text
#  plaid_item_access_token :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'test_helper'

class PlaidItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
