class BoletoTransactionOptions
  # Total de dias para expirar o boleto
  attr_accessor :DaysToAddInBoletoExpirationDate

  # Moeda. Opções: BRL, EUR, USD, ARS, BOB, CLP, COP, UYU, MXN, PYG
  attr_accessor :CurrencyIso
end
