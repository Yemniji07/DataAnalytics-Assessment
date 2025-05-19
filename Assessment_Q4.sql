SELECT 
    C.id AS customer_id,                                                    -- Customer ID
    CONCAT(C.first_name, " ", C.last_name) AS 'name',        -- Full name of the customer

    -- Number of months since the customer joined
    PERIOD_DIFF(
        DATE_FORMAT(CURDATE(), '%Y%m'),
        DATE_FORMAT(C.created_on, '%Y%m')
    ) AS 'tenure_months',

    -- Total transaction amount by the customer
    SUM(S.amount) AS 'total_transaction',

    -- Estimated CLV, only if tenure_months is not 0
    CASE 
        WHEN PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(C.created_on, '%Y%m')) = 0 THEN 0
        ELSE 
            (
                SUM(S.amount) / PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(C.created_on, '%Y%m'))
            ) * 12 * (0.1 * SUM(S.amount))
    END AS 'estimated_clv'

FROM users_customuser C

-- Join with savings account to access transactions
INNER JOIN savings_savingsaccount S ON C.id = S.owner_id

-- Grouping by customer
GROUP BY CONCAT(C.first_name, " ", C.last_name), C.id

-- Order by estimated CLV in descending order
ORDER BY estimated_clv DESC;