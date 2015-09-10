class SalesOption

  attr_accessor :IsAntiFraudEnabled

  attr_accessor :AntiFraudServiceCode

  attr_accessor :Retries

  attr_accessor :CurrencyIso

  @@IsoEnum = {
    :BRL => '986',
    :EUR => '978',
    :USD => '840',
    :ARS => '032',
    :BOB => '068',
    :CLP => '152',
    :COP => '170',
    :UYU => '858',
    :MXN => '484',
    :PYG => '600'
  }

  def initialize
    @CurrencyIso = self.IsoEnum[:BRL]
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
