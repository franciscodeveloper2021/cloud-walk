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
  let(:transactions_history) { [] }
  let(:service) do
    described_class.new(transaction_payload: transaction_payload, transactions_history: transactions_history)
  end

  let(:transaction_response_dto_deny) do
    TransactionResponseDto.new(transaction_payload["transaction_id"], "deny")
  end
  let(:transaction_response_dto_approve) do
    TransactionResponseDto.new(transaction_payload["transaction_id"], "approve")
  end

  describe "#initialize" do
    it "initializes with transaction_payload as instance variable" do
      expect(service.instance_variable_get(:@transaction_payload)).to eq(transaction_payload)
    end

    it "initializes with transactions_history as instance variable" do
      expect(service.instance_variable_get(:@transactions_history)).to eq(transactions_history)
    end
  end

  describe "#call" do
    context "with suspicious activity" do
      context "when any transaction on transaction history receives a charge back" do
        it "returns recommendation deny" do
          transactions_history << {
            "transaction_id" => 2342356,
            "merchant_id" => 29744,
            "user_id" => 97051,
            "card_number" => "434505******9116",
            "transaction_date" => "2019-11-30T23:12:32.812632",
            "transaction_amount" => 100,
            "device_id" => 285475,
            "has_charge_back" => true
          }

          result = service.call

          expect(result).to eq(transaction_response_dto_deny)
        end
      end

      context "when user is trying too many transactions in a row" do
        it "returns recommendation deny" do
          transactions_history << {
            "transaction_id" => 2342356,
            "merchant_id" => 29744,
            "user_id" => 97051,
            "card_number" => "434505******9116",
            "transaction_date" => (DateTime.parse(transaction_payload["transaction_date"]) - Rational(4, 24 * 60)).to_s,
            "transaction_amount" => 100,
            "device_id" => 285475
          }

          result = service.call

          expect(result).to eq(transaction_response_dto_deny)
        end
      end

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

      it "adds transaction payload on transaction history" do
        service.call

        expect(transactions_history.last).to eq(transaction_payload)
      end
    end
  end
end
