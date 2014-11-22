class AccountSubInvest < ActiveRecord::Base
  belongs_to :account_sub_product
  belongs_to :account_product

  def save_params(join_value, product)
    self.loan_number = product.deposit_number
    self.account_product_id = product.id
    self.amount = join_value
    self.remain_principal = self.amount
    self.annual_rate = product.annual_rate
    self.current_period = 0
    if product.repayment_method == "profit_principal"
      month_rate = self.annual_rate / 12 /100
      self.fixed_pp_amount =  (self.amount * month_rate * (1 + month_rate) ** product.repayment_period) / (((1 + month_rate) ** product.repayment_period) - 1)
    end
    self.save!
  end

  def process_profit(profits, rate)
    profit = AccountInvestProfit.new
    profit_amount = self.calculate_profit(rate)
    profit.refund_amount = profit_amount.round(2)
    profit.refund_time = Time.now
    profit.account_sub_invest_id = self.id
    # profit.save!
    self.account_sub_product.account_account.add_balance(profit_amount, "profit", self.loan_number)
    profits << profit
    logger.info("the profit of #{self.loan_number} + with id#{self.id} is #{profit.refund_amount}")
  end

  def calculate_profit(rate)
    if self.account_product.repayment_method == "profit"
      self.amount * rate
    else
      self.remain_principal * rate
    end
  end


  def calculate_principal
    if self.account_product.repayment_method == "profit"
      self.amount
    else
      period_rate = self.account_product.each_repayment_period * self.annual_rate / 365 /100
      self.fixed_pp_amount - self.calculate_profit(period_rate)
    end
  end


  def cal_fixed_pp_amount
    month_rate = self.annual_rate/12/100
    (self.amount * month_rate * (1 + month_rate) ** self.account_product.repayment_period) / (((1 + month_rate) ** self.account_product.repayment_period) - 1)
  end


  def process_principal(principals, period)

    principal = AccountInvestPrincipal.new
    principal_amount = self.calculate_principal
    principal.refund_amount = principal_amount
    principal.refund_time = Time.now
    principal.account_sub_invest_id = self.id
    principal.save!

    self.account_sub_product.account_account.add_balance(principal_amount, "principal", self.loan_number)

    principals << principal
    # logger.info("the principal of #{self.loan_number} + with id#{self.id} is #{principal.refund_amount}")
  end

end
