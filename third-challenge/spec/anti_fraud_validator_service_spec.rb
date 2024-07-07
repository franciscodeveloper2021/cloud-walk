require 'rspec'
require_relative '../services/anti_fraud_validator_service'
require_relative '../dtos/transaction_response_dto'

RSpec.describe AntiFraudValidatorService do
  let(:transaction_payload) do
    {
      "transaction_id" => 2342357,
      "merchant_id" => 29744,
      "user_id" => 97051,
      "card_number" => "434505******9116",
      "transaction_date" => "2019-11-30T23:16:32.812632",
      "transaction_amount" => 373,
      "device_id" => 285475
    }
  end
  let(:service) { described_class.new(transaction_payload: transaction_payload) }

  let(:transaction_response_dto_deny) { TransactionResponseDto.new(transaction_payload["transaction_id"], "deny") }
  let(:transaction_response_dto_approve) { TransactionResponseDto.new(transaction_payload["transaction_id"], "approve") }

  describe "#initialize" do
    it "initializes with transaction_payload as instance variable" do
      expect(service.instance_variable_get(:@transaction_payload)).to eq(transaction_payload)
    end
  end

  describe "#call" do
    context "with suspicious activity" do
      context "when transaction amount exceeds the limit for transaction" do
        it "returns recommendation deny" do
          transaction_payload["transaction_amount"] = described_class::LIMIT_AMOUNT_FOR_TRANSACTION + 1

          result = service.call

          expect(result).to eq(transaction_response_dto_deny)
        end
      end

      context "when high transaction is happening at midnight" do
        it "returns recommendation deny" do
          transaction_payload["transaction_date"] = "2019-11-30T00:00:00.000000"
          transaction_payload["transaction_amount"] = described_class::LIMIT_AMOUNT_FOR_TRANSACTION

          result = service.call

          expect(result).to eq(transaction_response_dto_deny)
        end
      end

      context "when device id is nil" do
        it "returns recommendation deny" do
          transaction_payload["device_id"] = nil

          result = service.call

          expect(result).to eq(transaction_response_dto_deny)
        end
      end
    end

    context "when everything seems fine" do
      it "returns recommendation approve" do
        result = service.call

        expect(result).to eq(transaction_response_dto_approve)
      end
    end
  end
end
