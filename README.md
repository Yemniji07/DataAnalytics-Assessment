# Assessment_Q1
*The scripts was written so it can combine differently tables;*

### **CT1 — User Plans Summary**
*Joins the users_customuser table with the plans_plan table based on owner_id.*

***For each user, it calculates:***
*savings_count: number of plans where is_regular_savings = 1
investment_count: number of plans where is_a_fund = 1*

*Also constructs the user's full name by combining first_name and last_name.*

### **CT2 — User Savings Summary**
*Joins users_customuser with savings_savingsaccount on owner_id.
For each user, sums up the confirmed_amount in their savings accounts*

### **Final Output Query**
*Joins the two CTs (CT1 and CT2) using user ID.*

Selects:
Full name,
Savings plan count,
Investment plan count,
Total confirmed savings deposits.

Sorts results by total_deposits in descending order (i.e., highest savers first).


# Assessment_Q2

Categorized each user per month based on the number of transactions:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)

Then calculated the customer count, the toatal number of customer and also the average transaction per customer per month


# Assessment_Q3
Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)

plans_plan has the information for the finacial plans, so we join it together with saving_savingaccount to get date for each plan enrolled in, the finally with users table to check for active users


# Assessment_Q4
Here the query pulls data from users_customuser and joins it with savings_savingsaccount  using the customer’s ID
from this, the table is drawn out and also includes the estimated CLV



