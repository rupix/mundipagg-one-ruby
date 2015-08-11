class ErrorReport

  attr_acessor :Category

  attr_acessor :ErrorItemCollection


  def initialize
    @ErrorItemCollection = ErrorItem.new
  end

end
