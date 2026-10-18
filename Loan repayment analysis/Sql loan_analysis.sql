SELECT
    loan_paid_back,
    COUNT(*) AS total_loans
FROM loan_dataset_20000
GROUP BY loan_paid_back;

SELECT
    loan_paid_back,
    COUNT(*) AS total_loans,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM loan_dataset_20000),
        2
    ) AS percentage
FROM loan_dataset_20000
GROUP BY loan_paid_back;


SELECT
    LEFT(grade_subgrade, 1) AS loan_grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_paid_back) * 100, 2)
        AS repayment_rate
FROM loan_dataset_20000
GROUP BY LEFT(grade_subgrade, 1)
ORDER BY loan_grade;

SELECT
    loan_purpose,
    COUNT(*) AS total_loans,
     MAX(loan_amount) AS maximum_loan_amount,
    ROUND(AVG(loan_paid_back) * 100, 2)
        AS repayment_rate,
    ROUND(AVG(loan_amount), 2)
        AS average_loan_amount
FROM loan_dataset_20000
GROUP BY loan_purpose
ORDER BY maximum_loan_amount;


SELECT
    employment_status,

    COUNT(*) AS total_loans,
    SUM(loan_paid_back = 1) AS loans_paid_back,
    SUM(loan_paid_back = 0) AS loans_not_paid_back,
    MAX(loan_amount) AS maximum_loan_amount,
    
    ROUND(AVG(loan_paid_back) * 100, 2)
        AS repayment_rate,
    ROUND(AVG(loan_amount), 2)
        AS average_loan_amount,
	ROUND(AVG(delinquency_history), 2)
    AS average_delinquencies_history

FROM loan_dataset_20000
GROUP BY
    employment_status
ORDER BY
    employment_status;


SELECT
    CASE
        WHEN credit_score < 580 THEN 'Below 580'
        WHEN credit_score < 670 THEN '580-669'
        WHEN credit_score < 740 THEN '670-739'
        WHEN credit_score < 800 THEN '740-799'
        ELSE '800 and above'
    END AS credit_score_band,

    COUNT(*) AS total_loans,

    SUM(loan_paid_back = 1) AS loans_paid_back,

    SUM(loan_paid_back = 0) AS loans_not_paid_back,

    ROUND(
        AVG(loan_paid_back) * 100, 2
    ) AS repayment_rate_percentage

FROM loan_dataset_20000

GROUP BY credit_score_band
ORDER BY MIN(credit_score);


SELECT
    MIN(debt_to_income_ratio) AS minimum_dti,
    MAX(debt_to_income_ratio) AS maximum_dti,
    AVG(debt_to_income_ratio) AS average_dti,
    COUNT(DISTINCT debt_to_income_ratio) AS unique_dti_values
FROM loan_dataset_20000;

SELECT
    debt_to_income_ratio,
    COUNT(*) AS total_loans
FROM loan_dataset_20000
GROUP BY debt_to_income_ratio
ORDER BY debt_to_income_ratio
LIMIT 20;


SELECT
    CASE
        WHEN debt_to_income_ratio < 0.10
            THEN 'Below 10%'
        WHEN debt_to_income_ratio < 0.20
            THEN '10% - 19.99%'
        WHEN debt_to_income_ratio < 0.30
            THEN '20% - 29.99%'
        WHEN debt_to_income_ratio < 0.40
            THEN '30% - 39.99%'
        ELSE '40% and above'
    END AS dti_band,

    COUNT(*) AS total_loans,

    SUM(loan_paid_back = 1) AS loans_paid_back,

    SUM(loan_paid_back = 0) AS loans_not_paid_back,

    ROUND(
        AVG(loan_paid_back) * 100, 2
    ) AS repayment_rate_percentage,

    ROUND(
        AVG(loan_paid_back = 0) * 100, 2
    ) AS non_repayment_rate_percentage

FROM loan_dataset_20000

GROUP BY dti_band

ORDER BY MIN(debt_to_income_ratio);



SELECT
    CASE
        WHEN delinquency_history = 0 THEN 'No delinquencies'
        WHEN delinquency_history = 1 THEN '1 delinquency'
        WHEN delinquency_history BETWEEN 2 AND 3 THEN '2-3 delinquencies'
        ELSE '4 or more delinquency_history'
    END AS delinquency_group,

    COUNT(*) AS total_loans,

    SUM(loan_paid_back = 1) AS loans_paid_back,

    SUM(loan_paid_back = 0) AS loans_not_paid_back,

    ROUND(
        AVG(loan_paid_back) * 100, 2
    ) AS repayment_rate_percentage,

    ROUND(
        AVG(loan_paid_back = 0) * 100, 2
    ) AS non_repayment_rate_percentage

FROM loan_dataset_20000

GROUP BY delinquency_group

ORDER BY MIN(delinquency_history);



SELECT
    CASE
        WHEN annual_income < 25000 THEN 'Below 25K'
        WHEN annual_income < 50000 THEN '25K - 49,999'
        WHEN annual_income < 75000 THEN '50K - 74,999'
        WHEN annual_income < 100000 THEN '75K - 99,999'
        ELSE '100K and above'
    END AS annual_income_band,

    COUNT(*) AS total_borrowers,

    SUM(num_of_delinquencies > 0)
        AS borrowers_with_delinquencies,

    SUM(num_of_delinquencies = 0)
        AS borrowers_without_delinquencies,

    ROUND(
        SUM(num_of_delinquencies > 0) * 100.0 / COUNT(*),
        2
    ) AS delinquency_rate_percentage

FROM loan_dataset_20000
GROUP BY annual_income_band
ORDER BY MIN(annual_income);


SELECT
    CASE
        WHEN debt_to_income_ratio < 0.10 THEN 'Below 10%'
        WHEN debt_to_income_ratio < 0.20 THEN '10% - 19.99%'
        WHEN debt_to_income_ratio < 0.30 THEN '20% - 29.99%'
        WHEN debt_to_income_ratio < 0.40 THEN '30% - 39.99%'
        ELSE '40% and above'
    END AS dti_band,

    COUNT(*) AS total_borrowers,

    SUM(num_of_delinquencies > 0)
        AS borrowers_with_delinquencies,

    SUM(num_of_delinquencies = 0)
        AS borrowers_without_delinquencies,

    ROUND(
        SUM(num_of_delinquencies > 0) * 100.0 / COUNT(*),
        2
    ) AS delinquency_rate_percentage

FROM loan_dataset_20000
GROUP BY dti_band
ORDER BY MIN(debt_to_income_ratio);
