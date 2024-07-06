# Understand the Industry

## Questions to be Answered:

1. **Explain the money flow and the information flow in the acquirer market and the role of the main players.**

2. **Explain the difference between acquirer, sub-acquirer, and payment gateway and how the flow explained in question 1 changes for these players.**

3. **Explain what chargebacks are, how they differ from cancellations and what is their connection with fraud in the acquiring world.**

---

### 1. Explain the money flow and the information flow in the acquirer market and the role of the main players.

In the acquirer market, the money flow and information flow involve several key players:

- **Merchant**: The business that sells goods or services.
- **Customer**: The person buying the goods or services.
- **Acquirer**: The bank or financial institution that processes credit or debit card payments on behalf of the merchant.
- **Issuer**: The bank or financial institution that issued the customer's payment card.
- **Card Network**: The network (such as Visa, MasterCard, etc.) that facilitates communication between the acquirer and the issuer.

#### Money Flow:
1. The customer makes a purchase using a credit or debit card.
2. The merchant sends the transaction details to the acquirer.
3. The acquirer forwards the transaction details to the card network.
4. The card network requests authorization from the issuer.
5. The issuer approves or declines the transaction and sends the response back through the card network to the acquirer.
6. If approved, the acquirer deposits the funds (minus fees) into the merchant's account.
7. The issuer bills the customer for the transaction amount.

#### Information Flow:
1. The transaction details flow from the merchant to the acquirer.
2. The acquirer communicates with the card network to request authorization.
3. The card network contacts the issuer for approval.
4. The issuer sends the approval or decline response back through the card network to the acquirer.
5. The acquirer relays the response to the merchant, completing the transaction process.

---

### 2. Explain the difference between acquirer, sub-acquirer, and payment gateway and how the flow explained in question 1 changes for these players.

#### Acquirer:
- A financial institution that processes credit or debit card payments on behalf of a merchant.
- Directly involved in the money and information flow, ensuring transactions are authorized and settled.

#### Sub-Acquirer:
- An intermediary that works under the umbrella of an acquirer.
- Often partners with smaller merchants to provide payment processing services without needing a direct relationship with an acquirer.
- Sub-acquirers handle much of the interaction with the merchant, while the acquirer handles the actual transaction processing.

#### Payment Gateway:
- A service that securely transmits transaction information between the merchant's website and the acquirer.
- Acts as a bridge to facilitate online payments, ensuring data security and encryption.
- While it doesn't directly handle funds, it plays a critical role in the information flow.

#### Changes in Flow:
- **Sub-Acquirer**: The money flow still involves the acquirer, but the sub-acquirer acts as an intermediary, managing the merchant relationship and some operational aspects.
- **Payment Gateway**: The information flow includes an additional step where transaction data is transmitted securely from the merchant to the gateway, and then from the gateway to the acquirer.

---

### 3. Explain what chargebacks are, how they differ from cancellations and what is their connection with fraud in the acquiring world.

#### Chargebacks:
- A process where a customer disputes a transaction and requests a reversal of the payment.
- Initiated through the issuer, which contacts the acquirer to reverse the funds.
- Often involve a fee for the merchant and can impact their relationship with the acquirer.

#### Cancellations:
- Occur when a transaction is voided before it is completed or settled.
- Typically handled directly by the merchant, preventing the transaction from being processed.

#### Connection with Fraud:
- Chargebacks can be a result of fraudulent transactions where a customer's card is used without their authorization.
- High chargeback rates can indicate fraud and lead to increased scrutiny or penalties for the merchant.
- Merchants need to implement robust fraud prevention measures to minimize chargebacks and protect their reputation.

---