# mundipagg-one-ruby

### Mundipagg Gem Download
https://rubygems.org/gems/mundipagg_api

```ruby
$ gem install mundipagg_api
```

```ruby
require 'mundipagg_api'
```

Ruby DevKit is required.

### About Windows
The recommended Windows version of Ruby is Ruby 2.1.
For gems work correctly it'll be necessary run the following commands:

No Windows a versão do Ruby recomendada é a 2.1.
Para que todas as gemas funcionem corretamente é necessário realizar o seguinte processo:
```ruby
$ gem install rubygems-update
$ update_rubygems
$ gem update --system
```
### Required Gems
```ruby
$ gem install rest-client
$ gem install rspec
$ gem install nori
$ gem install gyoku
$ gem install nokogiri
$ gem install ffi
$ gem install bundler
```
### Bundler
Run the following commands to install gems:

Rode os seguintes comandos para instalar as gems:
```ruby
$ gem install bundler
$ bundle install
```

Running tests with `bundle exec`:

Rodando testes com `bundle exec`:
```ruby
$ bundle exec rspec spec/integration/gateway_spec.rb
```

Running tests with `rake`:

Rodando testes com `rake`:

```ruby
$ rake
```

## Code Examples

### Create a Credit Card Transaction
```ruby
require 'mundipagg_api'

# passa a merchantKey na variável
merchantKey = 'sua merchantKey'

# instancia classe com métodos de requisição
# :staging ou nada para ambiente sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(:production, merchantKey)

# coleta dados do cartão
creditCardTransaction = CreditCardTransaction.new
creditCardTransaction.AmountInCents = 100
creditCardTransaction.InstallmentCount = 1
creditCardTransaction.TransactionReference = 'CreditCard One RubySDK Test'
creditCardTransaction.CreditCardOperation = 'AuthOnly'
creditCardTransaction.Options.PaymentMethodCode = 1
creditCardTransaction.Options.SoftDescriptorText = 'My Store Name'
creditCardTransaction.CreditCard.CreditCardNumber = '5453010000066167'
creditCardTransaction.CreditCard.ExpMonth = 5
creditCardTransaction.CreditCard.ExpYear = 18
creditCardTransaction.CreditCard.HolderName = 'Maria do Carmo'
creditCardTransaction.CreditCard.SecurityCode = '123'
creditCardTransaction.CreditCard.CreditCardBrand = 'Mastercard'

# cria a transação
createSaleRequest = CreateSaleRequest.new
createSaleRequest.CreditCardTransactionCollection << creditCardTransaction

# faz a requisição de criação de transação, retorna um hash com a resposta
response = gateway.CreateSale(createSaleRequest)
```


### Create a BoletoTransaction
```ruby
require 'mundipagg_api'

# passa a merchantKey na variável
merchantKey = 'sua merchantKey'

# instancia classe com métodos de requisição
# :staging ou nada para ambiente sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(:production, merchantKey)

# instancia um objeto de transação de boleto
boletoTransaction = BoletoTransaction.new
boletoTransaction.AmountInCents = 100
boletoTransaction.BankNumber = '237'
boletoTransaction.DocumentNumber = '12345678901'
boletoTransaction.Instructions = 'Pagar antes do vencimento'
boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
boletoTransaction.Options.CurrencyIso = 'BRL'
boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

# instancia um objeto de request para fazer a criação de transação
createSaleRequest = CreateSaleRequest.new

# incrementa na coleção de boletos a transação de boleto criada
createSaleRequest.BoletoTransactionCollection << boletoTransaction

# faz a requisição de criação de transação, retorna um hash com a resposta
response = gateway.CreateSale(createSaleRequest)
```


### Cancel Method
```ruby
require 'mundipagg_api'

merchantKey = 'Sua Merchant Key'

# instancia classe com métodos de requisição
# :staging para ambiente sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(:staging, merchantKey)

# preenche um item de colecao, necessario para cancelamento da transacao de cartao de credito
cancelCreditCardTransactionItem = ManageCreditCardTransaction.new
cancelCreditCardTransactionItem.AmountInCents = 100
cancelCreditCardTransactionItem.TransactionKey = 'TransactionKey da transação'
cancelCreditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

# monta o objeto para cancelamento de transação
cancelSaleRequest = ManageSaleRequest.new
cancelSaleRequest.OrderKey = 'OrderKey AQUI'
cancelSaleRequest.CreditCardTransactionCollection << cancelCreditCardTransactionItem

# faz a requisição de cancelamento, retorna um hash com a resposta
response = gateway.Cancel(cancelSaleRequest)
```


### Capture Method
```ruby
require 'mundipagg_api'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com métodos de requisição
# :staging ou nada para ambiente de sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(merchantKey)

# itens necessários para captura da transacão
captureCreditCardTransactionItem = ManageCreditCardTransaction.new
captureCreditCardTransactionItem.AmountInCents = 100
captureCreditCardTransactionItem.TransactionKey = 'transactionKey da transação'
captureCreditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest (referência da transação)'

# monta o objeto para captura de transação
captureSaleRequest = ManageSaleRequest.new
captureSaleRequest.OrderKey = 'orderkey da transação'

# incrementa na coleção de CreditCardTransactionCollection
captureSaleRequest.CreditCardTransactionCollection << captureCreditCardTransactionItem

# faz a requisição de captura e salva na variável response
response = gateway.Capture(captureSaleRequest)
```


### Retry Method
```ruby
require 'mundipagg_api'

merchantKey = 'Sua Merchant Key'

# instancia classe com métodos de requisição
# :staging para ambiente sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(:staging, merchantKey)

retrySaleRequest = RetrySaleRequest.new
retrySaleCreditCardTransactionItem = RetrySaleCreditCardTransaction.new

# preenche um item de coleção
retrySaleCreditCardTransactionItem.SecurityCode = '123'
retrySaleCreditCardTransactionItem.TransactionKey = 'Transaction Key AQUI'

# monta o objeto de retentativa
retrySaleRequest.OrderKey = 'OrderKey AQUI'

# incrementa na coleção o item de retry
retrySaleRequest.RetrySaleCreditCardTransactionCollection << retrySaleCreditCardTransactionItem

# faz a requisição de retentativa, retorna um hash com a resposta
response = gateway.Retry(retrySaleRequest)
```


### Query Method
```ruby
require 'mundipagg_api'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com métodos de requisição
# :staging ou nada para ambiente de sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(merchantKey)

# inicializa a QuerySaleRequest
querySaleRequest = QuerySaleRequest.new

# preenche o campo de OrderKey para enviar um request de OrderKey
querySaleRequest.OrderKey = 'sua OrderKey'

# faz a requisição de Query passando QuerySaleRequest.QuerySaleRequestEnum[:OrderKey] para indicar
# que o método irá procurar por OrderKey e passa a OrderKey como segundo parâmetro
# retorna um hash com a resposta
responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)

# se a requisição for por OrderReference ela é bem parecida com a de cima, mudando apenas algumas coisas:
querySaleRequest.OrderReference = 'sua OrderReference'

responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)
```


### ParseXmlToNotification
The ParseXmlToNotification takes an XML and convert it to a hash variable.

O ParseXmlToNotification converte um XML para uma variável hash.

```ruby
require 'mundipagg_api'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com métodos de requisição
# :staging ou nada para ambiente de sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(merchantKey)

xml = 'xml que será passsado na variável'

# faz a requisição de PostNotification (parse do XML) e retorna um hash do XML passado
response = gateway.ParseXmlToNotification(xml)
```


### TransactionReportFile Method
```ruby
require 'mundipagg_api'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com métodos de requisição
# :staging ou nada para ambiente de sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(merchantKey)

# cria uma variável do tipo Date, passando apenas o ano, mês e dia (nessa ordem)
date = Date.new(2014, 12, 10)

# faz a requisição do TransactionReportFile e retorna uma string com os dados do report
response = gateway.TransactionReportFile(date)
```


##### TransactionReportFileParser
If you want the string that is received from TransactionReportFile Method to be parsed, there is a method for that.

Este método faz um parse na string recebida do método TransactionReportFile e retorna um hash.
```ruby
require 'mundipagg_api'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com métodos de requisição
# :staging ou nada para ambiente de sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(merchantKey)

# cria uma variável do tipo Date, passando apenas o ano, mês e dia (nessa ordem)
date = Date.new(2014, 12, 10)

# faz a requisição do TransactionReportFile e retorna uma string com os dados do report
request_to_parse = gateway.TransactionReportFile(date)

# faz um parse da string do TransactionReportFile e retorna um hash com a resposta
response = gateway.TransactionReportFileParser(request_to_parse)
```

##### TransactionReportFileDownloader
This method download and save the TransactionReportFile to a '.txt' file.

Este método faz o download e salva o TransactionReportFile em um arquivo '.txt' no local indicado.
```ruby
require 'mundipagg_api'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com métodos de requisição
# :staging ou nada para ambiente de sandbox e :production para ambiente de produção
gateway = MundipaggApi.new(merchantKey)

# cria uma variável do tipo Date, passando apenas o ano, mês e dia (nessa ordem)
date = Date.new(2015, 9, 15)

# faz a requisição do transaction report file e salva no destino passado como parâmetro
# o segundo parâmetro é o nome do arquivo, e o terceiro é o local onde será salvo o arquivo
# é salvo um arquivo em .txt no local indicado
response = gateway.TransactionReportFileDownloader(date, 'Teste', "C:\\Users\\YourUser\\Desktop\\")
```
