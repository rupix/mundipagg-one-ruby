require_relative '../../lib/mundipagg'

class Gateway

  attr_reader :serviceEnvironment

  attr_reader :merchantKey

  def initialize(environment=:staging, merchantKey)
    @serviceEnvironment = environment
    @merchantKey = merchantKey
    @@SERVICE_HEADERS = {:MerchantKey => "#{@merchantKey}",:Accept => 'application/json', :"Content-Type" => 'application/json'}
  end

  @@QUERY_SALE_REQUEST = QuerySaleRequest.new

  # URL de produ��o
  @@SERVICE_URL_PRODUCTION = 'https://transactionv2.mundipaggone.com/Sale/'

  # URL de homologa��o
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

      # se for homologa��o faz a chamada por aqui
      if @serviceEnvironment == :staging
        response = RestClient.get @@SERVICE_URL_STAGING + '/Query/' + querySaleRequestEnum + '=' + key, headers=@@SERVICE_HEADERS

        # se for produ��o, faz a chamada por aqui
      elsif @serviceEnvironment == :production
        response = RestClient.get @@SERVICE_URL_PRODUCTION + '/Query/' + querySaleRequestEnum + '=' + key, headers=@@SERVICE_HEADERS
      end

        # se der algum erro, trata aqui
    rescue Exception => e
      #errorReport.Category = e.message
      #errorReport.ErrorItemCollection = e.to_s
      return e
    end

    # se n�o houver erros, trata o json e retorna o objeto
    querySaleResponse = JSON.load response
    querySaleResponse
  end

  def CreateSale(createSaleRequest)

    saleHash = createSaleRequest.to_hash

    saleHash['BoletoTransactionCollection'] = []

    begin
      createSaleRequest.BoletoTransactionCollection.each do |boleto|
        b = boleto.to_json

        saleHash['BoletoTransactionCollection'] << b
      end
    rescue Exception => e
      puts e.message
    end

    postRequest(saleHash.to_json)
  end


  def postRequest(payload)
    response = nil
    begin
      if @serviceEnvironment == :staging
        response = RestClient.post(@@SERVICE_URL_STAGING, payload, headers=@@SERVICE_HEADERS)
      elsif @serviceEnvironment == :production
        response = RestClient.post(@@SERVICE_URL_PRODUCTION, payload, headers=@@SERVICE_HEADERS)
      end
    rescue RestClient::ExceptionWithResponse => err
      return err.message #err.response
    end
    json_response = JSON.load response
    json_response
  end

end