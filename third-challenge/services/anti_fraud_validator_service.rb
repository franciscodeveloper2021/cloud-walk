require 'date'

class AntiFraudValidatorService
  attr_reader :transaction_payload, :transactions_history

  LIMIT_AMOUNT_FOR_TRANSACTION = 35000
  MAX_TRANSACTIONS_PER_HOUR = 5

  def initialize(transaction_payload:, transactions_history:)
    @transaction_payload = transaction_payload
    @transactions_history = transactions_history
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
      :is_user_trying_too_many_transactions_in_a_row?,
      :is_transaction_amount_exceeding_the_limit?,
      :is_high_transaction_happening_at_midnight?,
      :is_device_id_nil?
    ]
  end

  def is_transaction_amount_exceeding_the_limit?
    transaction_payload["transaction_amount"] > LIMIT_AMOUNT_FOR_TRANSACTION
  end

  def is_high_transaction_happening_at_midnight?
    transaction_date = DateTime.parse(transaction_payload["transaction_date"])
    transaction_date.hour == 0 && transaction_payload["transaction_amount"] >= LIMIT_AMOUNT_FOR_TRANSACTION
  end

  def is_device_id_nil?
    transaction_payload["device_id"].nil?
  end

  def is_user_trying_too_many_transactions_in_a_row?
    return false if transactions_history.empty?

    latest_transaction_date = DateTime.parse(transactions_history.last["transaction_date"])
    upcoming_transaction_date = DateTime.parse(transaction_payload["transaction_date"])

    time_difference_in_minutes = ((upcoming_transaction_date - latest_transaction_date) * 24 * 60).to_f

    time_difference_in_minutes <=5
  end
end
