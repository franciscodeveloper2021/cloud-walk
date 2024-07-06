# Get your hands dirty

## Questions to be Answered:

__Using this csv with hypothetical transactional data, imagine that you are trying to understand if there is any kind of suspicious behavior.__

1. **Analyze the data provided and present your conclusions (consider that all transactions are made using a mobile device).**

2. **In addition to the spreadsheet data, what other data would you look at to try to find patterns of possible frauds?**

---

### 1. Analyze the data provided and present your conclusions (consider that all transactions are made using a mobile device).

#### Key Observations:

1. **High Transactions Amounts:**
   - Transactions with high amounts, such as $2556.13, $2092.79, $2803.32, $2597.51, and others could be flagged for review. Large transactions are often scrutinized as they carry higher risk.

2. **Repeated Transactions:**
   - Repeated transactions in a short time frame with the same card number and device ID, such as:
     - `device_id: 486` has several transactions with high amounts ($188.68, $352.77, $345.68, $32.86) close in time.
     - Card ending in `3381` with `device_id: 656429` has multiple transactions of high amounts ($2597.51, $2511.43, $2515.13) within a few minutes.
   - This could indicate a pattern of potential abuse or fraudulent activity.

3. **Chargebacks:**
   - Transaction marked with `has_cbk: TRUE` indicate a chargeback, which is a red flag for fraudulent behavior. Monitoring these closely can help identify patterns of fraud.

4. **Missing Device IDs:**
   - Transactions with `device_id` missing (null values) might indicate incomplete data or attempts to obsfucate the transaction details.

#### Specific Suspicious Activities:

1. **Device ID 486:**
   - Multiple transactions within minutes:
     - `2019-12-01T21:24:05.608374` - $188.68
     - `2019-12-01T21:13:21.529999` - $352.77
     - `2019-12-01T21:04:55.066909` - $345.68
     - `2019-12-01T20:36:55.091278` - $32.86
   - Same card number `650516******9201` used repeatedly, indicating possible fraud or misuse.

2. **Device ID 656429:**
   - Multiple high-value transactions:
     - `2019-12-01T19:31:20.047571` - $2597.51
     - `2019-12-01T19:26:01.352512` - $2511.43
     - `2019-12-01T19:12:42.641216` - $2515.13
   - Same card number `606282******3381` used in quick succession.

---

### 2. In addition to the spreadsheet data, what other data would you look at to try to find patterns of possible frauds?

To further investigate and identify patterns of possible fraud, the following additional data would be useful:

1. **Geolocation Data:**
  - Location where each transaction was made to detect unusual or impossible travel patterns like transaction within a short time.

2. **IP Address:**
  - IP addresses used for transactions to identify suspicious patterns or known fraudulent IP addresses.

3. **Historical Transaction Data:**
  - Historical transaction for each card and device to compare against typical behavior patterns.

4. **Transaction Decline Data:**
   - Data on declined transactions, which might indicate repeated attempts to use compromised card details.

5. **User Reports:**
   - Reports from users regarding unauthorized transactions to identify and correlate with suspicious patterns.

By combining the initial analysis with these additional data points, a more comprehensive understanding of potential fraud patterns can be developed, leading to better prevention and detection mechanisms.

---