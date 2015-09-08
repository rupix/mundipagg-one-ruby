require 'json'
require 'rest-client'

require_relative 'mundipagg/address'
require_relative 'mundipagg/Address/billing_address'
require_relative 'mundipagg/Address/buyer_address'
require_relative 'mundipagg/Address/delivery_address'

require_relative 'mundipagg/AntiFraud/anti_fraud_analysis_result'
require_relative 'mundipagg/AntiFraud/query_sale_anti_fraud_analysis_data'
require_relative 'mundipagg/AntiFraud/query_sale_anti_fraud_analysis_history_data'

require_relative 'mundipagg/BoletoTransaction/boleto_transaction'
require_relative 'mundipagg/BoletoTransaction/boleto_transaction_data'
require_relative 'mundipagg/BoletoTransaction/boleto_transaction_options'
require_relative 'mundipagg/BoletoTransaction/boleto_transaction_result'

require_relative 'mundipagg/CreditCardTransaction/credit_card'
require_relative 'mundipagg/CreditCardTransaction/credit_card_transaction'
require_relative 'mundipagg/CreditCardTransaction/credit_card_transaction_data'
require_relative 'mundipagg/CreditCardTransaction/credit_card_transaction_options'
require_relative 'mundipagg/CreditCardTransaction/retry_sale_credit_card_transaction'

require_relative 'mundipagg/InstantBuy/get_instant_buy_data_response'

require_relative 'mundipagg/Merchant/merchant'
require_relative 'mundipagg/Order/order'

require_relative 'mundipagg/Person/buyer'


require_relative 'mundipagg/Recurrency/recurrency'

require_relative 'mundipagg/Sale/create_sale_request'
require_relative 'mundipagg/Sale/manage_sale_request'
require_relative 'mundipagg/Sale/query_sale_request'
require_relative 'mundipagg/Sale/request_data'
require_relative 'mundipagg/Sale/retry_sale_options'
require_relative 'mundipagg/Sale/retry_sale_request'
require_relative 'mundipagg/Sale/sale_data'

require_relative 'mundipagg/SalesOption'

require_relative 'mundipagg/gateway'

