class AddPeriodNumbers < ActiveRecord::Migration
  def change
    add_column :account_products, :current_profit_period, :integer,  :default => 0
    add_column :account_products, :current_principal_period, :integer,  :default => 0
    add_column :account_sub_invests, :current_profit_period, :integer,  :default => 0
    add_column :account_sub_invests, :current_principal_period, :integer,  :default => 0
    add_column :account_invest_profits, :profit_number, :integer,  :default => 0
    add_column :account_invest_principals, :principal_number, :integer,  :default => 0
    add_column :account_product_profits, :profit_number, :integer,  :default => 0
    add_column :account_product_principals, :principal_number, :integer,  :default => 0
  end
end
