class QuerySaleRequest
  attr_accessor :OrderKey

  attr_accessor :OrderReference

  attr_accessor :CreditCardTransactionKey

  attr_accessor :CreditCardTransactionReference

  attr_accessor :BoletoTransactionKey

  attr_accessor :BoletoTransactionReference

  attr_accessor :QuerySaleRequestEnum

  # Enum feito para as chamadas do método query
  @@QuerySaleRequestEnum = {
      :OrderKey => 'OrderKey',
      :OrderReference => 'OrderReference',
      :CreditCardTransactionKey => 'CreditCardTransactionKey',
      :CreditCardTransactionReference => 'CreditCardTransactionReference',
      :BoletoTransactionKey => 'BoletoTransactionKey',
      :BoletoTransactionReference => 'BoletoTransactionReference'
  }

  def self.QuerySaleRequestEnum
    @@QuerySaleRequestEnum
  end

end