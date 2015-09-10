class BoletoTransactionData
  # Url para visualização do boleto
  attr_accessor :BoletoUrl

  # Código de barras do boleto
  attr_accessor :Barcode

  # Status do boleto
  attr_accessor :BoletoTransactionStatus

  @@BoletoTransactionStatusEnum = {
      # Gerado
      :Generated => '1',

      # Visualizado
      :Viewed => '2',

      # Pago com valor abaixo
      :Underpaid => '3',

      # Pago com valor maior
      :Overpaid => '4',

      # Pago
      :Paid => '5',

      # Cancelado
      :Voided => '6',

      # Com erro
      :WithError => '99'
  }

  # Chave da transação. Utilizada para identificar a transação de boleto no gateway
  attr_accessor :TransactionKey

  # Valor original do boleto em centavos
  attr_accessor :AmountInCents

  # Número do documento
  attr_accessor :DocumentNumber

  # Identificador da transação no sistema da loja
  attr_accessor :TransactionReference

  # Data de expiração do boleto
  attr_accessor :ExpirationDate

  # Número do banco
  attr_accessor :BankNumber

  # Valor total pago em centavos
  attr_accessor :AmountPaidInCents

  # Data de criação do boleto no gateway
  attr_accessor :CreateDate

  # Identificador do boleto
  attr_accessor :NossoNumero

  def initialize
    @BoletoTransactionStatus = self.BoletoTransactionStatusEnum
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end