class ShoppingCart

  attr_accessor :FreighCostInCents

  attr_accessor :EstimatedDeliveryDate

  attr_accessor :DeliveryDeadline

  attr_accessor :ShippingCompany

  attr_accessor :DeliveryAddress

  attr_accessor :ShoppingCartItemCollection

  def initialize
    @ShoppingCartItemCollection = ShoppingCartItem.new;
  end

end