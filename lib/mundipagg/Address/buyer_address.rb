class BuyerAddress
  # País. Opções: Brazil, USA, Argentina, Bolivia, Chile, Colombia, Uruguay, Mexico, Paraguay
  attr_accessor :Country

  # Estado
  attr_accessor :State

  # Cidade
  attr_accessor :City

  # Distrito
  attr_accessor :District

  # Logradouro
  attr_accessor :Street

  # Número
  attr_accessor :Number

  # Complemento
  attr_accessor :Complement

  # CEP
  attr_accessor :ZipCode

  # Tipo de endereço
  attr_accessor :AddressType

  @@AddressTypeEnum = {
    :Undefined => '0',
    :Comercial => '1',
    :Residential => '2'
  }

  def initialize
    @AddressType = self.AddressTypeEnum
  end
end
