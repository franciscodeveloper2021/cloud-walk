# Anti-Fraud Validator Service

## Overview

This Anti-Fraud Validator Service is designed to detect and prevent fraudulent transactions before they are authorized. The service is implemented in Ruby and is capable of evaluating transaction data against a set of predefined rules to determine whether a transaction should be approved or denied. The key features include:

- Checking for previous chargebacks in transaction history.
- Limiting the number of transactions a user can perform in a short period.
- Rejecting transactions that exceed a certain amount.
- Identifying high-value transactions occurring at midnight.
- Ensuring all transactions have a device ID associated with them.
