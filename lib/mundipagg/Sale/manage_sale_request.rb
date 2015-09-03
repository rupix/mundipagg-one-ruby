class ManageSaleRequest

  attr_accessor :CreditCardTransactionCollection

  attr_accessor :OrderKey

  def initialize
    @CreditCardTransactionCollection = Array.new;
  end

end