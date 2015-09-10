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

    # boletoTransactionOptions = BoletoTransactionOptions.new
    # boletoTransactionOptions.CurrencyIso = 'BRL'

    # boletoTransaction.Options << boletoTransactionOptions
    # boletoTransaction.Options = {
    #     :CurrencyIso => 'BRL',
    #     :DaysToAddInBoletoExpirationDate => 5
    # }

    # createSaleRequest.ShoppingCartCollection = nil
    # createSaleRequest.CreditCardTransactionCollection = nil

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