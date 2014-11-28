class AccountProduct < ActiveRecord::Base
  has_many :account_sub_products
  has_many :account_sub_invests
  has_many :account_product_profits
  has_many :account_product_principals

  def add_fixed_amount_save(join_value)
    self.fixed_invest_amount += join_value
    self.save!
  end

  def has_profit?
    end_date =self.join_date + (self.each_repayment_period * self.repayment_period).days
    (end_date < Date.today) && (self.last_profit_date + self.each_repayment_period.days <= end_date)

    # self.last_profit_date + self.each_repayment_period.days < Time.now
  end

  def has_principal?
    end_date =self.join_date + (self.each_repayment_period * self.repayment_period).days
    (end_date < Date.today) && (self.last_principal_date + self.each_repayment_period.days <= end_date)
    # self.last_principal_date + self.each_repayment_period.days < Time.now
  end

  # def last_profit_date
  #   profits = self.account_product_profits
  #   if profits.size > 0
  #     return profits.last.refund_time
  #   else
  #     return self.join_date
  #   end
  # end


  def last_profit_date
    t = self.current_profit_period * self.each_repayment_period
    time = self.join_date + t.days
  end

  def last_principal_date
    t = self.current_principal_period * self.each_repayment_period
    time = self.join_date + t.days
  end


  def current_profit
    self.fixed_invest_amount * self.each_repayment_period * self.annual_rate / 365 /100
  end

  def current_principal
    if self.repayment_method == "profit"
      if self.last_period?
        return self.fixed_invest_amount
      else
        return 0
      end
    elsif self.repayment_method == "profit_principal"
      return self.calculate_principal
    else
      return 0
    end

  end

  def calculate_principal
    return (self.fixed_invest_amount / self.repayment_period).round(2)
  end


  def last_period?
    self.join_date + (self.each_repayment_period * self.repayment_period).days < Date.today
  end


  def pay_profits
    invests = self.account_sub_invests
    invest_profits = []
    # amount = self.fixed_invest_amount
    period_rate = self.each_repayment_period * self.annual_rate / 365 /100
    # period_number = (Date.today - self.last_profit_date).to_i / self.each_repayment_period
    # total_profit = amount * period_rate
    product_profit = AccountProductProfit.new(:refund_amount => self.current_profit, :account_product_id => self.id, :refund_time => Time.now,)
    invests.each do |inv|
      inv.process_profit(invest_profits, period_rate, self.current_profit_period)
    end
    jso = invest_profits.to_json(:only => [:refund_amount, :refund_time, :account_sub_invest_id, :profit_number])
    self.current_profit_period += 1
    self.save!
    product_profit.profit_number = self.current_profit_period + 1
    product_profit.save!
    # logger.info("last profit date is  #{self.last_profit_date}")
    # logger.info("the profit list is #{invest_profits[0].refund_amount}")
    # logger.info("the total profit is #{jso.to_s}")
    return jso
  end


  def pay_principals
    invests = self.account_sub_invests
    principals = []
    product_principal = AccountProductPrincipal.new(:refund_amount => self.current_principal, :account_product_id => self.id, :refund_time => Time.now)
    invests.each do |inv|
      inv.process_principal(principals, self.current_principal_period)
    end
    jso = principals.to_json(:only => [:refund_amount, :refund_time, :account_sub_invest_id, :principal_number])
    current_period = self.update_principal_period
    self.save!
    product_principal.principal_number = current_period
    product_principal.save!
    # logger.info("the total principal is #{jso.to_s}")
    return jso
  end


  def update_principal_period
    if self.repayment_method == "profit_principal"
      return self.current_principal_period += 1
    elsif self.repayment_method == "profit"
      return self.current_principal_period = self.repayment_period
    else
    end
  end

end
