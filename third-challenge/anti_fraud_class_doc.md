This Anti-Fraud Validator Service is designed to detect and prevent fraudulent transactions before they are authorized. The service is implemented in Ruby and uses Sinatra to create a simple web API for processing transaction data. The service evaluates transaction data against a set of predefined rules to determine whether a transaction should be approved or denied. Key features of this service include:

- **Checking for Previous Chargebacks**: Transactions are denied if the user has a history of chargebacks.
- **Limiting Transaction Frequency**: A user attempting too many transactions in a short period will have their transactions denied.
- **Transaction Amount Limits**: Transactions exceeding a predefined amount are denied.
- **High-Value Transactions at Midnight**: Transactions of high value occurring at midnight are flagged as potentially fraudulent and denied.
- **Device ID Verification**: Transactions without a device ID are automatically denied.

## Sinatra Implementation

### Setting Up Sinatra

The service is hosted using Sinatra, a lightweight web framework for Ruby. Here’s how the Sinatra app is set up:

1. **Gemfile**: Add Sinatra and other dependencies:
    ```ruby
    # frozen_string_literal: true

    source "https://rubygems.org"

    gem "rspec"
    gem "sinatra"
    gem "json" # For parsing and generating JSON data
    ```

2. **Install Dependencies**:
    ```sh
    bundle install
    ```

3. **Create the Sinatra Application**:

    Create a file named `app.rb` with the following content:

    ```ruby
    require 'sinatra'
    require 'json'
    require_relative 'services/anti_fraud_validator_service'
    require_relative 'dtos/transaction_response_dto'

    # Endpoint Implementation using Sinatra
    post '/anti_fraud_check' do
      request_payload = JSON.parse(request.body.read)
      transactions_history = [] # This would be replaced with a call to your persistent storage

      service = AntiFraudValidatorService.new(transaction_payload: request_payload, transactions_history: transactions_history)
      result = service.call

      content_type :json
      result.to_json
    end
    ```

4. **Run the Sinatra Server**:
    ```sh
    ruby app.rb -o 0.0.0.0 -p 4567
    ```

### Testing with `curl`

You can test the Anti-Fraud Validator Service using `curl`. Here are two test cases, one expected to return "deny" and another to return "approve".

#### Case 1: Deny

This case tests a transaction with an amount exceeding the limit (`36000`).

```sh
curl -X POST http://localhost:4567/anti_fraud_check \
     -H "Content-Type: application/json" \
     -d '{
           "transaction_id": 2342357,
           "merchant_id": 29744,
           "user_id": 97051,
           "card_number": "434505******9116",
           "transaction_date": "2019-11-30T23:16:32.812632",
           "transaction_amount": 36000,
           "device_id": 285475
         }'
```
#### Case 2: Approve

```sh
curl -X POST http://localhost:4567/anti_fraud_check \
     -H "Content-Type: application/json" \
     -d '{
           "transaction_id": 2342357,
           "merchant_id": 29744,
           "user_id": 97051,
           "card_number": "434505******9116",
           "transaction_date": "2019-11-30T23:16:32.812632",
           "transaction_amount": 373,
           "device_id": 285475
         }'
```