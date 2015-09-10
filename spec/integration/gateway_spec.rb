require_relative '../../lib/mundipagg'


merchantKey = '8A2DD57F-1ED9-4153-B4CE-69683EFADAD5'
gateway = Gateway.new(:production, merchantKey)

RSpec.describe Gateway do
  it 'should Create a Sale with Boleto' do
    createSaleRequest = CreateSaleRequest.new

    boletoTransaction = BoletoTransaction.new
    boletoTransaction.AmountInCents = 100
    boletoTransaction.BankNumber = '237'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.BillingAddress = nil
    boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
    boletoTransaction.Options.CurrencyIso = 'BRL'
    boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    # response = gateway.CreateSale(createSaleRequest)
    # puts response
    # expect(response[:ErrorReport]).to eq nil
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

    puts createSaleRequest

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
end