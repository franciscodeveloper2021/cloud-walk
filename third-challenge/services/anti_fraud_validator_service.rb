require 'date'

class AntiFraudValidatorService
  attr_reader :transaction_payload

  LIMIT_AMOUNT_FOR_TRANSACTION = 35000

  def initialize(transaction_payload:)
    @transaction_payload = transaction_payload
  end

  def call
    return TransactionResponseDto.new(transaction_payload["transaction_id"], "deny") if is_any_condition_to_deny_true?

    TransactionResponseDto.new(transaction_payload["transaction_id"], "approve")
  end

  private

  def is_any_condition_to_deny_true?
    conditions.any? { |condition| send(condition) }
  end

  def conditions
    [
      :is_transaction_amount_too_high,
      :is_high_transaction_happening_at_midnight?,
      :is_device_id_nil?
    ]
  end

  def is_transaction_amount_too_high
    transaction_payload["transaction_amount"] > LIMIT_AMOUNT_FOR_TRANSACTION
  end

  def is_high_transaction_happening_at_midnight?
    transaction_date = DateTime.parse(transaction_payload["transaction_date"])
    transaction_date.hour == 0 && transaction_payload["transaction_amount"] >= LIMIT_AMOUNT_FOR_TRANSACTION
  end

  def is_device_id_nil?
    transaction_payload["device_id"].nil?
  end
end
