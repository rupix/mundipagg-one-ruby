require_relative '../../lib/mundipagg'

RSpec.describe Gateway do
  it 'should Create a Sale with Boleto' do

    merchantKey = '8A2DD57F-1ED9-4153-B4CE-69683EFADAD5'
    gateway = Gateway.new(:production, merchantKey)


    querySaleRequest = QuerySaleRequest.new

    createSaleRequest = CreateSaleRequest.new
    boletoTransaction = BoletoTransaction.new
    boletoTransaction.AmountInCents = 100
    boletoTransaction.BankNumber = '237'
    boletoTransaction.DocumentNumber = '12345678901'
    boletoTransaction.Instructions = 'Pagar antes do vencimento'
    boletoTransaction.BillingAddress = nil

    boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    boletoTransactionOptions = BoletoTransactionOptions.new
    boletoTransactionOptions.CurrencyIso = 'BRL'
    boletoTransaction.Options = {
        :CurrencyIso => 'BRL',
        :DaysToAddInBoletoExpirationDate => 5
    }

    order = Order.new
    order.OrderReference = 'asdfasdfasdfasfa'
    #createSaleRequest.Order = order

    createSaleRequest.ShoppingCartCollection = nil
    createSaleRequest.CreditCardTransactionCollection = nil

    puts gateway.CreateSale(createSaleRequest)
  end
end