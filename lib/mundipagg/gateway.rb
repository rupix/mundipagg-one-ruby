class Gateway

  attr_accessor :serviceEnvironment

  @@SERVICE_URL_PRODUCTION = ''

  @@SERVICE_URL_STAGING = ''

  def initialize(environment=:staging)

    @serviceEnvironment = environment

  end

  def PostRequest(request)

  end

end