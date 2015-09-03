class ManageSaleResponse
  # Coleção de transações de cartão de crédito
  attr_accessor :CreditCardTransactionResultCollection

  def initialize
    @CreditCardTransactionResultCollection = Array.new
  end
end