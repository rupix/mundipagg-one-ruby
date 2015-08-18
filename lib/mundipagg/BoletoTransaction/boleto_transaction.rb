class BoletoTransaction

  attr_accessor :AmountInCents

  attr_accessor :BankNumber

  attr_accessor :Instructions

  attr_accessor :DocumentNumber

  attr_accessor :TransactionReference

  attr_accessor :TransactionDateTimeInMerchant

  attr_accessor :Options

  attr_accessor :BillingAddress


  def initialize
    @Options = BoletoTransactionOptions.new
  end

end