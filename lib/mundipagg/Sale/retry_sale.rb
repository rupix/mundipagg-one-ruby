class RetrySale

  attr_accessor :OrderKey

  attr_accessor :Options

  attr_accessor :RetrySaleCreditCardTransactionCollection

  def initialize
    @RetrySaleCreditCardTransactionCollection = Array.new;
  end

end