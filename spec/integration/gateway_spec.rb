require_relative '../../lib/mundipagg'
require_relative 'test_helper'

merchantKey = 'be43cb17-3637-44d0-a45e-d68aaee29f47'
gateway = Gateway.new(merchantKey)

RSpec.describe Gateway do
  it 'should Create a Sale with Boleto' do
    createSaleRequest = CreateSaleRequest.new

    boletoTransaction = BoletoTransaction.new
    boletoTransaction.AmountInCents = 100
    boletoTransaction.BankNumber = '237'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
    boletoTransaction.Options.CurrencyIso = 'BRL'
    boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    response = gateway.CreateSale(createSaleRequest)
    puts response
    expect(response[:ErrorReport]).to eq nil
  end

  it 'should create a Sale with CreditCard' do
    createSaleRequest = CreateSaleRequest.new

    buyerAddress = BuyerAddress.new
    buyerAddress.AddressType = 'Residential'
    buyerAddress.City = 'Rio de Janeiro'
    buyerAddress.Complement = '10 Andar'
    buyerAddress.Country = 'Brazil'
    buyerAddress.District = 'Centro'
    buyerAddress.Number = '199'
    buyerAddress.State = 'RJ'
    buyerAddress.Street = 'Rua da Quitanda'
    buyerAddress.ZipCode = '20091005'

    creditCardTransaction = CreditCardTransaction.new
    creditCardTransaction.AmountInCents = 100
    creditCardTransaction.InstallmentCount = 1
    creditCardTransaction.TransactionReference = 'CreditCard One RubySDK Test'
    creditCardTransaction.Options.PaymentMethodCode = 1
    creditCardTransaction.Options.SoftDescriptorText = 'My Store Name'
    creditCardTransaction.CreditCard.CreditCardNumber = '5453010000066167'
    creditCardTransaction.CreditCard.ExpMonth = 5
    creditCardTransaction.CreditCard.ExpYear = 18
    creditCardTransaction.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransaction.CreditCard.SecurityCode = '123'
    creditCardTransaction.CreditCard.CreditCardBrand = 'Mastercard'
    creditCardTransaction.CreditCard.BillingAddress.City = 'Rio de Janeiro'
    creditCardTransaction.CreditCard.BillingAddress.Complement = '10 Andar'
    creditCardTransaction.CreditCard.BillingAddress.Country = 'Brazil'
    creditCardTransaction.CreditCard.BillingAddress.District = 'Centro'
    creditCardTransaction.CreditCard.BillingAddress.Number = '199'
    creditCardTransaction.CreditCard.BillingAddress.State = 'RJ'
    creditCardTransaction.CreditCard.BillingAddress.Street = 'Rua da Quitanda'
    creditCardTransaction.CreditCard.BillingAddress.ZipCode = '20091005'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction
    createSaleRequest.Buyer.Birthdate = Date.new(2001, 9, 26).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.BuyerCategory = 'Normal'
    createSaleRequest.Buyer.Email = 'mundiBuyer@mundi.com.br'
    createSaleRequest.Buyer.EmailType = 'Personal'
    createSaleRequest.Buyer.Gender = 'M'
    createSaleRequest.Buyer.HomePhone = '22222222'
    createSaleRequest.Buyer.MobilePhone = '988888888'
    createSaleRequest.Buyer.WorkPhone = '25555555'
    createSaleRequest.Buyer.CreateDateInMerchant = (Date.parse(Time.now.to_s)).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.LastBuyerUpdateInMerchant = (Date.parse(Time.now.to_s)).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.DocumentNumber = '51212382749'
    createSaleRequest.Buyer.DocumentType = 'CPF'
    createSaleRequest.Buyer.Name = 'Jose da Silva Ramos'
    createSaleRequest.Buyer.PersonType = 'Person'
    createSaleRequest.Buyer.AddressCollection << buyerAddress

    response = gateway.CreateSale(createSaleRequest)
    puts response
    expect(response[:ErrorReport]).to eq nil

  end

  it 'should create a sale with all types of transactions and all fields filled' do
    buyerAddressItem = BuyerAddress.new
    buyerAddressItem.AddressType = 'Comercial'
    buyerAddressItem.City = 'Rio de Janeiro'
    buyerAddressItem.Complement = '10 Andar'
    buyerAddressItem.Country = 'Brazil'
    buyerAddressItem.District = 'Centro'
    buyerAddressItem.Number = '199'
    buyerAddressItem.State = 'RJ'
    buyerAddressItem.Street = 'Rua da Quitanda'
    buyerAddressItem.ZipCode = '20091005'

    boletoTransactionItem = BoletoTransaction.new
    boletoTransactionItem.AmountInCents = 350
    boletoTransactionItem.BankNumber = '237'
    boletoTransactionItem.BillingAddress.City = 'Rio de Janeiro'
    boletoTransactionItem.BillingAddress.Complement = '10º andar'
    boletoTransactionItem.BillingAddress.Country = 'Brazil'
    boletoTransactionItem.BillingAddress.District = 'Centro'
    boletoTransactionItem.BillingAddress.Number = '199'
    boletoTransactionItem.BillingAddress.State = 'RJ'
    boletoTransactionItem.BillingAddress.Street = 'Rua da Quitanda'
    boletoTransactionItem.BillingAddress.ZipCode = '20091005'
    boletoTransactionItem.DocumentNumber = '12345678901'
    boletoTransactionItem.Instructions = 'Pagar antes do vencimento'
    boletoTransactionItem.Options.CurrencyIso = 'BRL'
    boletoTransactionItem.Options.DaysToAddInBoletoExpirationDate = 7
    boletoTransactionItem.TransactionDateInMerchant = Date.new(2014, 11, 5).strftime("%Y-%m-%dT%H:%M:%S")
    boletoTransactionItem.TransactionReference = 'RubySDK-BoletoTransactionTest'

    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 750
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.TransactionDateInMerchant = Date.new(2014, 11, 5).strftime("%Y-%m-%dT%H:%M:%S")
    creditCardTransactionItem.TransactionReference = 'RubySDK-CreditCardTransactionTest'
    creditCardTransactionItem.Options.CaptureDelayInMinutes = 0
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.ExtendedLimitCode = nil
    creditCardTransactionItem.Options.ExtendedLimitEnabled = false
    creditCardTransactionItem.Options.IataAmountInCents = 0
    creditCardTransactionItem.Options.InterestRate = 0
    creditCardTransactionItem.Options.MerchantCategoryCode = nil
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.Options.SoftDescriptorText = 'Nome da Loja'
    creditCardTransactionItem.Recurrency.DateToStartBilling = (Date.parse(Time.now.to_s)).strftime("%Y-%m-%dT%H:%M:%S")
    creditCardTransactionItem.Recurrency.Frequency = 'Monthly'
    creditCardTransactionItem.Recurrency.Interval = 1
    creditCardTransactionItem.Recurrency.OneDollarAuth = false
    creditCardTransactionItem.Recurrency.Recurrences = 2
    creditCardTransactionItem.CreditCard.BillingAddress.City = 'Rio de Janeiro'
    creditCardTransactionItem.CreditCard.BillingAddress.Complement = '10º andar'
    creditCardTransactionItem.CreditCard.BillingAddress.Country = 'Brazil'
    creditCardTransactionItem.CreditCard.BillingAddress.District = 'Centro'
    creditCardTransactionItem.CreditCard.BillingAddress.Number = '199'
    creditCardTransactionItem.CreditCard.BillingAddress.State = 'RJ'
    creditCardTransactionItem.CreditCard.BillingAddress.Street = 'Ruda da Quitanda'
    creditCardTransactionItem.CreditCard.BillingAddress.ZipCode = '20091005'
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.InstantBuyerKey = '00000000-0000-0000-0000-000000000000'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'

    shoppingCartItem = ShoppingCartItemCollection.new
    shoppingCartItem.Description = 'Descricao do Produto'
    shoppingCartItem.DiscountAmountInCents = 120
    shoppingCartItem.ItemReference = 'product#666'
    shoppingCartItem.Name = 'Nome do produto'
    shoppingCartItem.Quantity = 1
    shoppingCartItem.TotalCostInCents = 1100
    shoppingCartItem.UnitCostInCents = 1220

    shoppingCartCollectionItem = ShoppingCartCollection.new
    shoppingCartCollectionItem.DeliveryAddress.City = 'Rio de Janeiro'
    shoppingCartCollectionItem.DeliveryAddress.Complement = '10º andar'
    shoppingCartCollectionItem.DeliveryAddress.Country = 'Brazil'
    shoppingCartCollectionItem.DeliveryAddress.District = 'Centro'
    shoppingCartCollectionItem.DeliveryAddress.Number = '199'
    shoppingCartCollectionItem.DeliveryAddress.State = 'RJ'
    shoppingCartCollectionItem.DeliveryAddress.Street = 'Rua da Quitanda'
    shoppingCartCollectionItem.DeliveryAddress.ZipCode = '20091005'
    shoppingCartCollectionItem.DeliveryDeadline = Date.new(2014, 12, 5).strftime("%Y-%m-%dT%H:%M:%S")
    shoppingCartCollectionItem.EstimatedDeliveryDate = Date.new(2014, 11, 25).strftime("%Y-%m-%dT%H:%M:%S")
    shoppingCartCollectionItem.FreighCostInCents = 0
    shoppingCartCollectionItem.ShippingCompany = 'Nome da empresa responsável pela entrega'
    shoppingCartCollectionItem.ShoppingCartItemCollection << shoppingCartItem

    createSaleRequest = CreateSaleRequest.new
    createSaleRequest.Buyer.Birthdate = Date.new(1990, 3, 3).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.DocumentNumber = '12345678901'
    createSaleRequest.Buyer.DocumentType = 'CPF'
    createSaleRequest.Buyer.Email = 'someone@example.com'
    createSaleRequest.Buyer.EmailType = 'Personal'
    createSaleRequest.Buyer.FacebookId = ''
    createSaleRequest.Buyer.Gender = 'M'
    createSaleRequest.Buyer.HomePhone = '2112345678'
    createSaleRequest.Buyer.MobilePhone = '21987654321'
    createSaleRequest.Buyer.Name = 'Someone'
    createSaleRequest.Buyer.PersonType = 'Person'
    createSaleRequest.Buyer.TwitterId = ''
    createSaleRequest.Buyer.WorkPhone = '2178563412'
    createSaleRequest.Buyer.BuyerCategory = 'Normal'
    createSaleRequest.Buyer.BuyerKey = '00000000-0000-0000-0000-000000000000'
    createSaleRequest.Buyer.BuyerReference = 'RubyBuyer#JohnConnor'
    createSaleRequest.Buyer.CreateDateInMerchant = Date.new(2014, 4, 15).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.LastBuyerUpdateInMerchant = Date.new(2014, 4, 15).strftime("%Y-%m-%dT%H:%M:%S")
    createSaleRequest.Buyer.AddressCollection << buyerAddressItem
    createSaleRequest.Merchant.MerchantReference = 'Nome da Loja'
    createSaleRequest.Options.AntiFraudServiceCode = 0
    createSaleRequest.Options.CurrencyIso = 'BRL'
    createSaleRequest.Options.IsAntiFraudEnabled = false
    createSaleRequest.Options.Retries = 3
    createSaleRequest.Order.OrderReference = 'RubySDK-TestOrder'
    createSaleRequest.RequestData.EcommerceCategory = 'B2B'
    createSaleRequest.RequestData.IpAddress = '127.0.0.1'
    createSaleRequest.RequestData.Origin = ''
    createSaleRequest.RequestData.SessionId = ''
    createSaleRequest.BoletoTransactionCollection << boletoTransactionItem
    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem

    response = gateway.CreateSale(createSaleRequest)
    puts response
    expect(response[:ErrorReport]).to eq nil
  end

  querySaleRequest = QuerySaleRequest.new
  it 'should consult the order with ordekey' do
    querySaleRequest.OrderKey = '17950b36-eafd-4871-8be9-d45f09627d34'
    responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)
    puts responseQuery
    orderKey = responseQuery["SaleDataCollection"][0]["OrderData"]["OrderKey"]

    puts orderKey
    expect(orderKey).to eq querySaleRequest.OrderKey
  end

  it 'should consult the order with orderReference' do
    querySaleRequest.OrderReference = '5e6ea780'
    responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)
    puts responseQuery
    orderReference = responseQuery["SaleDataCollection"][0]["OrderData"]["OrderReference"]

    puts orderReference
    expect(orderReference).to eq querySaleRequest.OrderReference
  end

  it 'should do a retry method' do
    retrySaleRequest = RetrySaleRequest.new
    retrySaleCreditCardTransactionItem = RetrySaleCreditCardTransaction.new

    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.TransactionReference = 'RubySDK-RetryTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-RetryTest'

    # cria o pedido que sera usado para retentativa
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer a retentativa
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    # monta o objeto de retentativa
    retrySaleCreditCardTransactionItem.SecurityCode = '123'
    retrySaleCreditCardTransactionItem.TransactionKey = transactionKey
    retrySaleRequest.OrderKey = orderKey
    retrySaleRequest.RetrySaleCreditCardTransactionCollection << retrySaleCreditCardTransactionItem

    # faz a requisicao de retentativa
    response = gateway.Retry(retrySaleRequest)

    puts response
    # espera que o transaction key seja igual, significa que foi tudo ok no teste
    responseTransactionKey = response['CreditCardTransactionResultCollection'][0]['TransactionKey']

    expect(responseTransactionKey).to eq transactionKey

  end

  it 'should cancel a transaction' do
    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-CancelTest'

    # cria o pedido que sera usado para cancelamento
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer o cancelamento
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    # itens necessarios para cancelamento da transacao de cartao de credito
    cancelCreditCardTransactionItem = ManageCreditCardTransaction.new
    cancelCreditCardTransactionItem.AmountInCents = 100
    cancelCreditCardTransactionItem.TransactionKey = transactionKey
    cancelCreditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

    # monta o objeto para cancelamento de transacao
    cancelSaleRequest = ManageSaleRequest.new
    cancelSaleRequest.OrderKey = orderKey
    cancelSaleRequest.CreditCardTransactionCollection << cancelCreditCardTransactionItem

    response = gateway.Cancel(cancelSaleRequest)

    puts response

    # espera que o transaction key seja igual, significa que foi tudo ok no teste
    responseTransactionKey = response['CreditCardTransactionResultCollection'][0]['TransactionKey']

    expect(responseTransactionKey).to eq transactionKey
  end

  it 'should capture a transaction' do
    createSaleRequest = CreateSaleRequest.new
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '41111111111111'
    creditCardTransactionItem.CreditCard.ExpMonth = 10
    creditCardTransactionItem.CreditCard.ExpYear = 19
    creditCardTransactionItem.CreditCard.HolderName = 'Maria do Carmo'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCardOperation = 'AuthAndCapture'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.Options.CurrencyIso = 'BRL'
    creditCardTransactionItem.Options.PaymentMethodCode = 1
    creditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest'

    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem
    createSaleRequest.Order.OrderReference = 'RubySDK-CaptureTest'

    # cria o pedido que sera usado para captura
    responseCreate = gateway.CreateSale(createSaleRequest)

    # pega o orderkey e o transaction key da resposta que sao necessarios para fazer a captura
    orderKey = responseCreate["OrderResult"]["OrderKey"]
    transactionKey = responseCreate['CreditCardTransactionResultCollection'][0]['TransactionKey']

    # itens necessarios para captura da transacao de cartao de credito
    captureCreditCardTransactionItem = ManageCreditCardTransaction.new
    captureCreditCardTransactionItem.AmountInCents = 100
    captureCreditCardTransactionItem.TransactionKey = transactionKey
    captureCreditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest'

    # monta o objeto para cancelamento de transacao
    captureSaleRequest = ManageSaleRequest.new
    captureSaleRequest.OrderKey = orderKey
    captureSaleRequest.CreditCardTransactionCollection << captureCreditCardTransactionItem

    response = gateway.Capture(captureSaleRequest)

    # espera que o ErrorReport seja nulo, significa que foi tudo ok na transação
    expect(response['ErrorReport']).to eq nil
  end

  it 'should do a PostNotification interpretation' do
    creditCardTransactionItem = CreditCardTransaction.new
    creditCardTransactionItem.AmountInCents = 100
    creditCardTransactionItem.TransactionReference = 'Ruby PostNotification Test'
    creditCardTransactionItem.InstallmentCount = 1
    creditCardTransactionItem.CreditCardOperation = 'AuthOnly'
    creditCardTransactionItem.CreditCard.CreditCardBrand = 'Visa'
    creditCardTransactionItem.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransactionItem.CreditCard.HolderName = 'Bruce Wayne'
    creditCardTransactionItem.CreditCard.SecurityCode = '123'
    creditCardTransactionItem.CreditCard.ExpMonth = 5
    creditCardTransactionItem.CreditCard.ExpYear = 20
    creditCardTransactionItem.Options.PaymentMethodCode = 1

    createSaleRequest = CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransactionItem

    response_hash = gateway.CreateSale(createSaleRequest)

    credit_card_result = response_hash['CreditCardTransactionResultCollection'][0]

    expect(credit_card_result['Success']).to eq true
    expect(credit_card_result['CreditCardOperation']).to eq 'AuthOnly'
    expect(credit_card_result['CreditCardTransactionStatus']).to eq 'AuthorizedPendingCapture'

    captureCreditCardTransactionItem = ManageCreditCardTransaction.new
    captureCreditCardTransactionItem.AmountInCents = creditCardTransactionItem.AmountInCents
    captureCreditCardTransactionItem.TransactionKey = credit_card_result['TransactionKey']
    captureCreditCardTransactionItem.TransactionReference = creditCardTransactionItem.TransactionReference

    captureSale = ManageSaleRequest.new
    captureSale.OrderKey = response_hash['OrderResult']['OrderKey']
    captureSale.CreditCardTransactionCollection << captureCreditCardTransactionItem

    captureResponse = gateway.Capture(captureSale)

    expect(captureResponse['ErrorReport']).to eq nil


    xml = TestHelper.CreateFakePostNotification(response_hash, captureResponse)

    response = gateway.PostNotification(xml)

    puts response

    expect(response.nil?).to eq false
  end

  it 'should bring the transaction report file' do
    date = Date.new(2015, 3, 21)
    local_gateway = Gateway.new('be43cb17-3637-44d0-a45e-d68aaee29f47')
    result = local_gateway.TransactionReportFile(date)
    puts result
  end
end