class QuerySaleResponse
  # Lista de vendas
  attr_accessor :SaleDataCollection

  # Indicador do total de vendas
  attr_accessor :SaleDataCount

  def initialize
    @SaleDataCollection = Array.new
  end
end