require 'rspec'
require_relative '../services/anti_fraud_validator_service'

RSpec.describe AntiFraudValidatorService do
  it 'says hello' do
    service = AntiFraudValidatorService.new
    expect(service.say_hello).to eq('Hello, world!')
  end
end
