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

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash

    JSON.generate(hash)
  end

end