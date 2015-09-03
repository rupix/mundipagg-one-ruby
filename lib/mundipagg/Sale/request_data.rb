class RequestData
  # Identificador da origem de venda na loja
  attr_accessor :Origin

  # Identificador da sessão do usuário no sistema da loja (utilizado pelo serviço de antifraude)
  attr_accessor :SessionId

  # Endereço IP do cliente da loja
  attr_accessor :IpAddress

  # Categoria da venda e-commerce. B2B ou B2C
  attr_accessor :EcommerceCategory

  @@EcommerceCategoryEnum = {
      :B2B => '1',
      :B2C => '2'
  }

  def self.EcommerceCategory
    @@EcommerceCategoryEnum
  end

end