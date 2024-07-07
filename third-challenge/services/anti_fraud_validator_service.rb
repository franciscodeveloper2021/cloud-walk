require 'date'

class AntiFraudValidatorService
  attr_reader :transaction_payload

  def initialize(transaction_payload:)
    @transaction_payload = transaction_payload
  end

  def call
    if is_any_condition_to_deny_true?
      TransactionResponseDto.new(transaction_payload["transaction_id"], "deny")
    else
      TransactionResponseDto.new(transaction_payload["transaction_id"], "allow")
    end
  end

  private

  def is_any_condition_to_deny_true?
    conditions.any? { |condition| send(condition) }
  end

  def conditions
    [
      :is_high_transaction_happening_at_midnight?,
      :is_device_id_nil?
    ]
  end

  def is_high_transaction_happening_at_midnight?
    transaction_date = DateTime.parse(transaction_payload["transaction_date"])
    transaction_date.hour == 0 && is_transaction_amount_too_high
  end

  def is_device_id_nil?
    transaction_payload["device_id"].nil?
  end

  def is_transaction_amount_too_high
    transaction_payload["transaction_amount"] > 2000
  end
end
