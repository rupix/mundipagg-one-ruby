class BoletoTransactionOptions
  # Total de dias para expirar o boleto
  attr_accessor :DaysToAddInBoletoExpirationDate

  # Moeda. Opções: BRL, EUR, USD, ARS, BOB, CLP, COP, UYU, MXN, PYG
  attr_accessor :CurrencyIso

  @@CurrencyIsoEnum = {
        # Real
        :BRL => '986',
        # Euro
        :EUR => '978',
        # Dólar
        :USD => '840',
        # Argentine peso
        :ARS => '032',
        # Boliviano
        :BOB => '068',
        # Chilean peso
        :CLP => '152',
        # Colombian peso
        :COP => '170',
        # Uruguayan peso
        :UYU => '858',
        # Peso Mexicano
        :MXN => '484',
        # Paraguayan guaraní
        :PYG => '600'
  }

  def self.CurrencyIso
    @@CurrencyIsoEnum[:BRL]
  end
end
