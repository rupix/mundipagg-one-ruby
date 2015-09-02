class Recurrency
  # Frequência da recorrência
  attr_accessor :Frequency

  @@FrequencyEnum = {
      :Weekly => '1',
      :Monthly => '2',
      :Yearly => '3',
      :Daily => '4'
  }

  # Intervalo de recorrência
  attr_accessor :Interval

  # Data da primeira cobrança
  attr_accessor :DateToStartBilling

  # Total de recorrências
  attr_accessor :Recurrences

  # Informa se será necessário efetuar o procedimento OneDollarAuth antes de registrar a recorrência
  attr_accessor :OneDollarAuth

  def self.Frequency
    @@FrequencyEnum
  end
end