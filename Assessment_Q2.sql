SELECT 
    -- Categorize users based on the number of transactions in a month
    CASE 
        WHEN COUNT(confirmed_amount) <= 2 THEN 'Low Frequency'                     -- 2 or fewer transactions
        WHEN COUNT(confirmed_amount) > 2 AND COUNT(confirmed_amount) <= 9 THEN 'Medium Frequency'  -- 3 to 9 transactions
        WHEN COUNT(confirmed_amount) >= 10 THEN 'High Frequency'                  -- 10 or more transactions
    END AS 'frequency_category',

    -- Total number of transactions per user per month
    COUNT(owner_id) AS 'customer_count',

    -- Average transaction amount per user per month, rounded to 1 decimal place
    ROUND(AVG(confirmed_amount), 1) AS 'avg_transactions_per_month'

FROM savings_savingsaccount

-- Grouping by year and month of the transaction and the user
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m'), owner_id;