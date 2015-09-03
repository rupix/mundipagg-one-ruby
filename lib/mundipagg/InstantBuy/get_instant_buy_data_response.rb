class GetInstantBuyDataResponse
  # Lista de cartões de crédito
  attr_accessor :CreditCardDataCollection

  # Total de cartões de crédito retornados
  attr_accessor :CreditCardDataCount

  def initialize
    @CreditCardDataCollection = Array.new
  end
end