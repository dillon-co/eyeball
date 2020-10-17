class CreatePlaidItems < ActiveRecord::Migration[6.0]
  def change
    create_table :plaid_items do |t|

      t.string :bank_name
      t.text :plaid_item_id
      t.text :plaid_item_access_token

      t.timestamps
    end
  end
end
