require 'rest-client'
require 'json'
require '../../lib/mundipagg/Sale/query_sale_request'
require '../../lib/mundipagg/Sale/query_sale_response'
require '../../lib/mundipagg/ErrorReport'

class Gateway

  attr_reader :serviceEnvironment

  attr_reader :merchantKey

  def initialize(environment=:staging, merchantKey)
    @serviceEnvironment = environment
    @merchantKey = merchantKey
    @@SERVICE_HEADERS = {MerchantKey: "#{@merchantKey}", Accept: 'Application/json'}
  end

  @@QUERY_SALE_REQUEST = QuerySaleRequest.new

  # URL de produção
  @@SERVICE_URL_PRODUCTION = 'https://transactionv2.mundipaggone.com/Sale/'

  # URL de homologação
  @@SERVICE_URL_STAGING = 'https://stagingv2.mundipaggone.com/Sale/'

  def PostRequest(request)

  end

  #
  def Query(querySaleRequestEnum, key)
    # EXEMPLO DE REQUEST

    querySaleResponse = QuerySaleResponse.new

    errorReport = ErrorReport.new

    # try, tenta fazer o request
    begin

      # se for homologação faz a chamada por aqui
      if @serviceEnvironment == :staging
        response = RestClient.get @@SERVICE_URL_STAGING + '/Query/' + querySaleRequestEnum + '=' + key, headers=@@SERVICE_HEADERS

      # se for produção, faz a chamada por aqui
      elsif @serviceEnvironment == :production
        response = RestClient.get @@SERVICE_URL_PRODUCTION + '/Query/' + querySaleRequestEnum + '=' + key, headers=@@SERVICE_HEADERS
      end

    # se der algum erro, trata aqui
    rescue Exception=>e
      #errorReport.Category = e.message
      #errorReport.ErrorItemCollection = e.to_s
      return e
    end

    # se não houver erros, trata o json e retorna o objeto
    querySaleResponse = JSON.load response
    return querySaleResponse
  end
end


# JSON.pretty_generate variable
querySaleRequest = QuerySaleRequest.new
querySaleRequest.OrderReference = '2d339922'
querySaleRequest.OrderKey = '688f8412-0d35-494c-a885-616a0ef1a752'
merchantKey = ''
queryMethod = Gateway.new(:production, merchantKey)
puts queryMethod.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)
puts queryMethod.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)