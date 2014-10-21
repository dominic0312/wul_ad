class CreateAccSubInvest < ActiveRecord::Migration
  def change
    create_table :account_sub_invests do |t|
      t.integer :account_sub_product_id
      t.string :loan_number
      t.decimal :amount, precision: 14, scale: 2, default: 0.00
      t.integer :status, default: 0
      t.boolean :onsale, default: false
      t.decimal :discount_rate, default: 0
      t.integer :account_product_id
      t.decimal :resell_price, precision: 14, scale: 2, default: 0.00
      t.decimal :remain_principal, precision: 14, scale: 2, default: 0.00
      t.integer :current_period, default: 0
      t.decimal :annual_rate,precision: 6, scale: 2, default: 0.00
      t.decimal :fixed_pp_amount, precision: 14, scale: 2, default: 0.00
      t.timestamps
    end
  end
end
