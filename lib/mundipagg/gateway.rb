require_relative '../../lib/mundipagg'

class Gateway

  attr_reader :serviceEnvironment

  attr_reader :merchantKey

  def initialize(environment=:staging, merchantKey)
    @serviceEnvironment = environment
    @merchantKey = merchantKey
    @@SERVICE_HEADERS = {:MerchantKey => "#{@merchantKey}", :Accept => 'application/json', :"Content-Type" => 'application/json'}
  end

  # URL de production
  @@SERVICE_URL_PRODUCTION = 'https://transactionv2.mundipaggone.com/Sale/'

  # URL de homologation
  @@SERVICE_URL_STAGING = 'https://stagingv2.mundipaggone.com/Sale/'

  # permite que o integrador adicione uma busca por transacoes utilizando alguns criterios
  def Query(querySaleRequestEnum, key)
    # try, tenta fazer o request
    begin

      # se for homologacao faz a chamada por aqui
      if @serviceEnvironment == :staging
        response = RestClient.get @@SERVICE_URL_STAGING + '/Query/' + querySaleRequestEnum + '=' + key, headers=@@SERVICE_HEADERS

        # se for producao, faz a chamada por aqui
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

  # criar uma transacao na plataforma One utilizando um ou mais meios de pagamento
  def CreateSale(createSaleRequest)

    saleHash = createSaleRequest.to_hash

    saleHash['BoletoTransactionCollection'] = []

    begin
      # transforma o objeto de boleto em json
      if createSaleRequest.BoletoTransactionCollection != nil

        createSaleRequest.BoletoTransactionCollection.each_with_index do |boleto, index|
          b = boleto.to_json
          saleHash['BoletoTransactionCollection'] << b

          if boleto.Options != nil
            boleto_options = boleto.Options.to_json
            saleHash['BoletoTransactionCollection'][index]['Options'] = boleto_options
          end
        end
      end

      # transforma o objeto de cartao de credito em json
      if createSaleRequest.CreditCardTransactionCollection.any? == false
        saleHash['CreditCardTransactionCollection'] = nil
      else
        createSaleRequest.CreditCardTransactionCollection.each do |creditCard|
          c = creditCard.to_json
          saleHash['CreditCardTransactionCollection'] << c
        end
      end


      # transforma o objeto de shoppingcart em json
      if createSaleRequest.ShoppingCartCollection.any? == false
        saleHash['ShoppingCartCollection'] = nil
      else
        createSaleRequest.ShoppingCartCollection.each do |shoppingCart|
          s = shoppingCart.to_json
          saleHash['ShoppingCartCollection'] << s
        end
      end

      # transforma o objeto Buyer em json
      if createSaleRequest.Buyer != nil
        createSaleRequest.Buyer.each do |buyer|
          b = buyer.to_json
          saleHash['Recurrency'] << b

          if createSaleRequest.Buyer.AddressCollection != nil
            createSaleRequest.Buyer.AddressCollection.each do |address|
              a = address.to_json
              saleHash['AddressCollection'] << a
            end
          end
        end
      end
    rescue Exception => e
      puts e.message
    end

    if @serviceEnvironment == :staging
      url = @@SERVICE_URL_STAGING
    elsif @serviceEnvironment == :production
      url = @@SERVICE_URL_PRODUCTION
    end
    postRequest(saleHash.to_json, url)
  end

  # permite forcar a retentativa manualmente de uma transacao (podendo ser tambem uma recorrencia) nao autorizada
  def Retry(retrySaleRequest)
    saleHash = retrySaleRequest.to_hash
    saleHash['RetrySaleCreditCardTransactionCollection'] = []

    begin
      if retrySaleRequest.RetrySaleCreditCardTransactionCollection != nil
        retrySaleRequest.RetrySaleCreditCardTransactionCollection.each do |retrySale|
          r = retrySale.to_json
          saleHash['RetrySaleCreditCardTransactionCollection'] << r
        end
      end
    rescue Exception => e
      puts e.message
    end
    if @serviceEnvironment == :staging
      url = @@SERVICE_URL_STAGING + '/Retry'
    elsif @serviceEnvironment == :production
      url = @@SERVICE_URL_PRODUCTION + '/Retry'
    end
    postRequest(saleHash.to_json, url)
  end

  # eh uma forma de desfazer uma transação com cartao de credito mesmo a transacao sendo capturada
  def Cancel(cancelSaleRequest)
    saleHash = cancelSaleRequest.to_hash
    saleHash['CreditCardTransactionCollection'] = []

    begin
      if cancelSaleRequest.CreditCardTransactionCollection != nil
        cancelSaleRequest.CreditCardTransactionCollection.each do |creditCard|
          c = creditCard.to_json
          saleHash['CreditCardTransactionCollection'] << c
        end
      end
    rescue Exception => e
      puts e.message
    end
    if @serviceEnvironment == :staging
      url = @@SERVICE_URL_STAGING + '/Cancel'
    elsif @serviceEnvironment == :production
      url = @@SERVICE_URL_PRODUCTION + '/Cancel'
    end
    postRequest(saleHash.to_json, url)
  end

  # confirmacao de uma transacao de cartao de credito que ja fora autorizada
  def Capture(captureRequest)
    saleHash = captureRequest.to_hash
    saleHash['CreditCardTransactionCollection'] = []

    begin
      if captureRequest.CreditCardTransactionCollection != nil
        captureRequest.CreditCardTransactionCollection.each do |creditCard|
          c = creditCard.to_json
          saleHash['CreditCardTransactionCollection'] << c
        end
      end
    rescue Exception => e
      puts e.message
    end
    if @serviceEnvironment == :staging
      url = @@SERVICE_URL_STAGING + '/Capture'
    elsif @serviceEnvironment == :production
      url = @@SERVICE_URL_PRODUCTION + '/Capture'
    end
    postRequest(saleHash.to_json, url)
  end

  def PostNotification()

  end

  def TransactionReportFile()

  end

  def postRequest(payload, url)
    response = nil
    begin
      response = RestClient.post(url, payload, headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      return err.message #err.response
    end
    json_response = JSON.load response
    json_response
  end
end
