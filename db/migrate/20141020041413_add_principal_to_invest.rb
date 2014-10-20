class AddPrincipalToInvest < ActiveRecord::Migration
  def change
    add_column :account_sub_invests, :remain_principal, :decimal
    add_column :account_sub_invests, :current_period, :integer
  end
end
