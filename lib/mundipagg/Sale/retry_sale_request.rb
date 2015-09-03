require 'retry_sale_options'

class RetrySaleRequest

  attr_accessor :OrderKey

  attr_accessor :Options

  attr_accessor :RetrySaleCreditCardTransactionCollection

  def initialize
    @RetrySaleCreditCardTransactionCollection = Array.new;
    @Options = RetrySaleOptions.new
  end

end