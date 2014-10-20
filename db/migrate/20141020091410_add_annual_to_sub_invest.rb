class AddAnnualToSubInvest < ActiveRecord::Migration
  def change
    add_column :account_sub_invests, :annual_rate, :decimal
  end
end
