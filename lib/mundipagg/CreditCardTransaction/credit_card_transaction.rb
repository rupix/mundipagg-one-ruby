class CreditCardTransaction

  attr_accessor :CreditCard

  attr_accessor :Options

  attr_accessor :Recurrence

  attr_accessor :AmountInCents

  attr_accessor :InstallmentCount

  attr_accessor :CreditCardOperationEnum

  attr_accessor :TransactionReference

  attr_accessor :TransactionDateInMerchant


  def initialize
    @Options = CreditCardTransactionOptions.new
  end

end