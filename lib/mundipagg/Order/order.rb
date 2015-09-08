class Order
  # Identificador do pedido no sistema da loja
  attr_accessor :OrderReference

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end