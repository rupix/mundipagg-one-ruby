class BoletoTransactionResult
  # Url para visualização do boleto
  attr_accessor :BoletoUrl

  # Código de barras
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

  # Valor original da transação em centavos
  attr_accessor :AmountInCents

  # Número do documento
  attr_accessor :DocumentNumber

  # Identificador da transação no sistema da loja
  attr_accessor :TransactionReference

  # Indica se houve sucesso na geração do boleto
  attr_accessor :Success

  # Número de identificação do boleto
  attr_accessor :NossoNumero

  def initialize
    @BoletoTransactionStatus = self.BoletoTransactionStatusEnum
  end
end