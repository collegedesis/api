class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :beneficiary_id

      t.timestamps
    end
  end
end
