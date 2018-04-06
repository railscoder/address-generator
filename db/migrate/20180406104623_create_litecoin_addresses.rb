class CreateLitecoinAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :litecoin_addresses do |t|

      t.string :private_hex, null: false
      t.string :public_hex, null: false
      t.string :address, null: false, index: true

      t.timestamps
    end
  end
end
