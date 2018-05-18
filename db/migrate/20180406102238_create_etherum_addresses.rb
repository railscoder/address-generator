class CreateEtherumAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :ethereum_addresses do |t|

      t.string :private_hex, null: false
      t.string :public_hex, null: false
      t.string :address, null: false, index: true
      t.float :amount, default: 0.0
      t.float :token_amount, default: 0.0
      t.string :tx_id, defualt: nil
      t.boolean :funds_withdrawn, default: false
      t.timestamps
    end
  end
end
