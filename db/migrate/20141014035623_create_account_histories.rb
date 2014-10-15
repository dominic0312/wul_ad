class CreateAccountHistories < ActiveRecord::Migration
  def change
    create_table :account_histories do |t|
      t.string :action
      t.decimal :amount, :precision => 14, :scale=>2
      t.integer :account_id
      t.string :account_name
      t.string :direction
      t.string :product_name
      t.string :asset_id
      t.timestamps
    end
  end
end
