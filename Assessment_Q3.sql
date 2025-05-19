SELECT 
    P.id AS 'Plan_id',                                -- Plan ID
    P.owner_id,                                       -- Owner (user) ID

    -- Determine plan type based on flags
    CASE 
        WHEN P.is_a_fund = 1 THEN 'Investment'         -- If it's a fund, label as Investment
        WHEN P.is_regular_savings = 1 THEN 'Savings'   -- If it's regular savings, label as Savings
    END AS 'type',

    S.transaction_date as 'last_transaction_date',                               -- Date of the transaction

    -- Number of days since the last transaction
    DATEDIFF(CURDATE(), S.transaction_date) AS 'inactivity_days'

FROM plans_plan P

-- Join to get related savings transactions
INNER JOIN savings_savingsaccount S ON P.id = S.plan_id

-- Join to check user status
INNER JOIN users_customuser C ON P.owner_id = C.id

-- Conditions:
-- 1. Only include transactions older than 365 days
-- 2. User must be active
-- 3. Plan must be either a fund OR a regular savings plan
WHERE 
    DATEDIFF(CURDATE(), S.transaction_date) > 365
    AND C.is_active = 1
    AND (P.is_a_fund = 1 OR P.is_regular_savings = 1);