require 'rest-client'
require 'json'
require '../../lib/mundipagg/Sale/query_sale_request'
require '../../lib/mundipagg/Sale/query_sale_response'
require '../../lib/mundipagg/ErrorReport'
require '../../lib/mundipagg/Sale/create_sale_request'
require '../../lib/mundipagg/BoletoTransaction/boleto_transaction'
require '../../lib/mundipagg/BoletoTransaction/boleto_transaction_options'
require '../../lib/mundipagg/Address/billing_address'

class Gateway

  attr_reader :serviceEnvironment

  attr_reader :merchantKey

  def initialize(environment=:staging, merchantKey)
    @serviceEnvironment = environment
    @merchantKey = merchantKey
    @@SERVICE_HEADERS = {MerchantKey: "#{@merchantKey}", Accept: 'application/json', 'Content-Type': 'application/json'}
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
    rescue Exception=>e
      #errorReport.Category = e.message
      #errorReport.ErrorItemCollection = e.to_s
      return e
    end

    # se n�o houver erros, trata o json e retorna o objeto
    querySaleResponse = JSON.load response
    return querySaleResponse
  end

  def CreateSale(createSaleRequest)
    begin
      if @serviceEnvironment == :staging
        response = RestClient.post(@@SERVICE_URL_STAGING,createSaleRequest.to_json, headers=@@SERVICE_HEADERS)
      elsif @serviceEnvironment == :production
        response = RestClient.post(@@SERVICE_URL_PRODUCTION, createSaleRequest.to_json, headers=@@SERVICE_HEADERS)
      end
    rescue RestClient::ExceptionWithResponse => err
      return err.message #err.response
    end
    puts response
    createSaleResponse = JSON.load response
    return createSaleResponse
  end
end


# JSON.pretty_generate variable
querySaleRequest = QuerySaleRequest.new
querySaleRequest.OrderReference = '2d339922'
querySaleRequest.OrderKey = '688f8412-0d35-494c-a885-616a0ef1a752'
merchantKey = '8A2DD57F-1ED9-4153-B4CE-69683EFADAD5'
queryMethod = Gateway.new(:production, merchantKey)
#puts queryMethod.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)
#puts queryMethod.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)

createSaleRequest = CreateSaleRequest.new
boletoTransaction = BoletoTransaction.new
boletoTransaction.AmountInCents = 100
boletoTransaction.BankNumber = '237'
boletoTransaction.DocumentNumber = '12345678901'
boletoTransaction.Instructions = 'Pagar antes do vencimento'
boletoTransaction.BillingAddress = nil
#boletoTransactionOptions = BoletoTransactionOptions.new
#boletoTransactionOptions.CurrencyIso = 'BRL'
boletoTransaction.Options = {
    :CurrencyIso => 'BRL',
    :DaysToAddInBoletoExpirationDate => 5
}
boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
createSaleRequest.BoletoTransactionCollection = boletoTransaction
createSaleRequest.ShoppingCartCollection = nil
createSaleRequest.CreditCardTransactionCollection = nil

#createSaleRequest = {
#    :AmountInCents => boletoTransaction.AmountInCents,
#    :BankNumber => boletoTransaction.BankNumber,
#    :DocumentNumber => boletoTransaction.DocumentNumber,
#    :Instructions => boletoTransaction.Instructions,
#    :Options => boletoTransaction.Options,
#    :TransactionReference => boletoTransaction.TransactionReference
#}

# usado pra tentar passar na mão o request...
#{
#    :AmountInCents => 100,
#    :BankNumber => '237',
#    :DocumentNumber => '12345678901',
#    :Instructions => 'Pagar antes do vencimento',
#    :Options => {
#        :CurrencyIso => 'BRL',
#        :DaysToAddInBoletoExpirationDate => 5
#    },
#    :TransactionReference => 'FUNCIONA RUBY!'
#}

toJson = createSaleRequest.to_json
puts toJson.to_s

puts queryMethod.CreateSale(createSaleRequest)