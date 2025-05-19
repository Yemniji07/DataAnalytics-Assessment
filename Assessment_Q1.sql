-- First Common Table (CT1): 
-- This CT retrieves each user's ID, full name (first + last name), 
-- and the number of investment plans associated with them.
-- and the number of savingins plans associated with them.
WITH CT1 AS (
    SELECT 
        C.id, 
        CONCAT(C.first_name, ' ', C.last_name) AS name,         -- Concatenates first and last name as 'name'
        COUNT(CASE WHEN P.is_regular_savings = 1 THEN P.id END) AS savings_count,  -- Counts the number of savings plans
		COUNT(CASE WHEN P.is_a_fund = 1 THEN P.id END) AS investment_count       -- Counts the number of investment plans

    FROM users_customuser C
    LEFT JOIN plans_plan P ON C.id = P.owner_id                 -- Joins user with plans based on user ID
    GROUP BY C.id, C.first_name, C.last_name                                  -- Groups by user ID and first name
),

-- Second Common Table  (CT2): 
-- This CT retrieves each user's ID, the number of savings records, 
-- and the total confirmed_amount saved by each user.
CT2 AS (
    SELECT 
        C.id, 
        COALESCE(SUM(S.confirmed_amount), 0) AS total_deposits                         -- Sums up all savings confirmed_amounts
    FROM users_customuser C
    LEFT JOIN savings_savingsaccount S ON C.id = S.owner_id     -- Joins user with savings based on user ID
    GROUP BY C.id, C.first_name                                   -- Groups by user ID and first name
)

-- Final query:
-- Combines the results from CT1 and CT2 using LEFT JOIN on user ID,
-- and selects full name, savings count, investment count, and total deposits.
SELECT 
    CT1.name, 
    CT1.savings_count, 
    CT1.investment_count, 
    CT2.total_deposits 
FROM CT1
LEFT JOIN CT2 ON CT1.id = CT2.id
ORDER BY CT2.total_deposits DESC;