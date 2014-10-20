class AddFixedPpAmountToInvest < ActiveRecord::Migration
  def change
    add_column :account_sub_invests, :fixed_pp_amount, :decimal, :precision => 14, :scale => 2, :default => 0.00
  end
end
