require 'rspec'
require_relative '../services/anti_fraud_validator_service'


RSpec.describe AntiFraudValidatorService do
  let(:transaction_payload) do
    {
      "transaction_id" => 2342357,
      "merchant_id" => 29744,
      "user_id" => 97051,
      "card_number" => "434505******9116",
      "transaction_date" => "2019-11-31T23:16:32.812632",
      "transaction_amount" => 373,
      "device_id" => 285475
    }
  end
  let(:service) { described_class.new(transaction_payload: transaction_payload) }

  describe "#initialize" do
    it "initializes with transaction_payload as instance variable" do
      expect(service.instance_variable_get(:@transaction_payload)).to eq(transaction_payload)
    end
  end
end
