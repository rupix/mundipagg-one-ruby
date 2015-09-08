class SaleOrderData
  # Número do pedido no sistema da loja
  attr_accessor :OrderReference

  # Chave do pedido. Utilizado para identificar o pedido no Gateway
  attr_accessor :OrderKey

  # Data de criação do pedido no Gateway
  attr_accessor :CreateDate
end