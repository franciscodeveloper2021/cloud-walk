require 'sinatra'
require 'json'
require_relative 'services/anti_fraud_validator_service'
require_relative 'dtos/transaction_response_dto'

post '/anti_fraud_check' do
  request_payload = JSON.parse(request.body.read)
  transactions_history = []

  service = AntiFraudValidatorService.new(transaction_payload: request_payload, transactions_history: transactions_history)
  result = service.call

  content_type :json
  result.to_json
end
