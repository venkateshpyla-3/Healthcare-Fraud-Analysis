create database healthcare_claims;
use healthcare_claims;
CREATE TABLE health_claims (
    Patient_ID BIGINT,
    Policy_Number VARCHAR(50),
    Claim_ID BIGINT PRIMARY KEY,
    Claim_Date DATE,
    Service_Date DATE,
    Policy_Expiration_Date DATE,
    Claim_Amount DECIMAL(12,2),
    Patient_Age INT,
    Patient_Gender VARCHAR(20),
    Patient_City VARCHAR(100),
    Patient_State VARCHAR(50)
);
ALTER TABLE health_claims
ADD COLUMN Hospital_ID INT,
ADD COLUMN Provider_Type VARCHAR(100),
ADD COLUMN Provider_Specialty VARCHAR(100),
ADD COLUMN Provider_City VARCHAR(100),
ADD COLUMN Provider_State VARCHAR(50),
ADD COLUMN Diagnosis_Code VARCHAR(50),
ADD COLUMN Procedure_Code INT,
ADD COLUMN Number_of_Procedures INT,
ADD COLUMN Admission_Type VARCHAR(50),
ADD COLUMN Discharge_Type VARCHAR(100),
ADD COLUMN Length_of_Stay_Days INT,
ADD COLUMN Service_Type VARCHAR(50),
ADD COLUMN Deductible_Amount DECIMAL(10,2),
ADD COLUMN CoPay_Amount DECIMAL(10,2),
ADD COLUMN Number_of_Previous_Claims_Patient INT,
ADD COLUMN Number_of_Previous_Claims_Provider INT,
ADD COLUMN Provider_Patient_Distance_Miles DECIMAL(10,2),
ADD COLUMN Claim_Submitted_Late BOOLEAN,
ADD COLUMN Is_Fraudulent BOOLEAN;
describe health_claims;
select count(*)
from health_claims;
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Claim_ID) AS unique_claims
FROM health_claims;
SELECT
    COUNT(*) AS total_claims,
    ROUND(SUM(Claim_Amount), 2) AS total_claim_amount,
    ROUND(AVG(Claim_Amount), 2) AS avg_claim_amount,
    ROUND(MIN(Claim_Amount), 2) AS min_claim_amount,
    ROUND(MAX(Claim_Amount), 2) AS max_claim_amount
FROM health_claims;
SELECT
    COUNT(*) AS fraudulent_claims,
    ROUND(SUM(Claim_Amount), 2) AS fraudulent_claim_amount,
    ROUND(AVG(Claim_Amount), 2) AS avg_fraud_claim_amount
FROM health_claims
WHERE Is_Fraudulent = 1;
SELECT
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(
        SUM(Is_Fraudulent) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM health_claims;
SELECT
    Is_Fraudulent,
    COUNT(*) AS total_claims,
    ROUND(AVG(Claim_Amount), 2) AS avg_claim_amount,
    ROUND(SUM(Claim_Amount), 2) AS total_claim_amount
FROM health_claims
GROUP BY Is_Fraudulent;
SELECT
    Claim_Submitted_Late,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(
        SUM(Is_Fraudulent) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM health_claims
GROUP BY Claim_Submitted_Late;
SELECT
    Admission_Type,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(
        SUM(Is_Fraudulent) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM health_claims
GROUP BY Admission_Type
ORDER BY fraud_rate_percentage DESC;
SELECT
    Service_Type,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(
        SUM(Is_Fraudulent) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM health_claims
GROUP BY Service_Type
ORDER BY fraud_rate_percentage DESC;
SELECT
    Provider_Specialty,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(
        SUM(Is_Fraudulent) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM health_claims
GROUP BY Provider_Specialty
ORDER BY fraud_rate_percentage DESC
limit 5;
SELECT
    Provider_Specialty,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(SUM(Is_Fraudulent) * 100.0 / COUNT(*), 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Provider_Specialty
ORDER BY fraud_rate_percentage DESC
LIMIT 5;
SELECT
    Provider_Type,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(SUM(Is_Fraudulent) * 100.0 / COUNT(*), 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Provider_Type
ORDER BY fraud_rate_percentage DESC;
SELECT
    CASE
        WHEN Claim_Amount < 500000 THEN 'Below 500K'
        WHEN Claim_Amount < 1000000 THEN '500K - 1M'
        WHEN Claim_Amount < 1500000 THEN '1M - 1.5M'
        WHEN Claim_Amount < 2000000 THEN '1.5M - 2M'
        ELSE '2M+'
    END AS claim_amount_range,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY claim_amount_range
ORDER BY MIN(Claim_Amount);
SELECT
    CASE
        WHEN Patient_Age <= 17 THEN '0-17'
        WHEN Patient_Age <= 30 THEN '18-30'
        WHEN Patient_Age <= 45 THEN '31-45'
        WHEN Patient_Age <= 60 THEN '46-60'
        ELSE '61+'
    END AS age_group,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY age_group
ORDER BY MIN(Patient_Age);
SELECT
    CASE
        WHEN Provider_Patient_Distance_Miles < 100 THEN 'Below 100'
        WHEN Provider_Patient_Distance_Miles < 300 THEN '100-299'
        WHEN Provider_Patient_Distance_Miles < 500 THEN '300-499'
        WHEN Provider_Patient_Distance_Miles < 700 THEN '500-699'
        ELSE '700+'
    END AS distance_range,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY distance_range
ORDER BY MIN(Provider_Patient_Distance_Miles);
SELECT
    Number_of_Previous_Claims_Provider,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Number_of_Previous_Claims_Provider
ORDER BY Number_of_Previous_Claims_Provider;
SELECT
    Number_of_Previous_Claims_Provider,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Number_of_Previous_Claims_Provider
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_percentage DESC;
SELECT
    Patient_Gender,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Patient_Gender
ORDER BY fraud_rate_percentage DESC;
SELECT
    Patient_State,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Patient_State
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_percentage DESC;
SELECT
    Hospital_ID,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Hospital_ID
HAVING COUNT(*) >= 20
ORDER BY fraud_rate_percentage DESC
LIMIT 10;
SELECT
    Hospital_ID,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(SUM(
        CASE 
            WHEN Is_Fraudulent = 1 THEN Claim_Amount 
            ELSE 0 
        END
    ), 2) AS fraudulent_claim_amount
FROM health_claims
GROUP BY Hospital_ID
ORDER BY fraudulent_claim_amount DESC
LIMIT 10;
SELECT
    Hospital_ID,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(SUM(
        CASE 
            WHEN Is_Fraudulent = 1 THEN Claim_Amount 
            ELSE 0 
        END
    ), 2) AS fraudulent_claim_amount
FROM health_claims
GROUP BY Hospital_ID
ORDER BY fraudulent_claim_amount DESC
LIMIT 10;
SELECT
    Diagnosis_Code,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Diagnosis_Code
HAVING COUNT(*) >= 50
ORDER BY fraud_rate_percentage DESC
LIMIT 10;
SELECT
    Procedure_Code,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Procedure_Code
HAVING COUNT(*) >= 50
ORDER BY fraud_rate_percentage DESC
LIMIT 10;
SELECT
    Number_of_Procedures,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Number_of_Procedures
ORDER BY Number_of_Procedures;
SELECT
    CASE
        WHEN Length_of_Stay_Days = 0 THEN '0 Days'
        WHEN Length_of_Stay_Days <= 7 THEN '1-7 Days'
        WHEN Length_of_Stay_Days <= 14 THEN '8-14 Days'
        WHEN Length_of_Stay_Days <= 30 THEN '15-30 Days'
        ELSE '31+ Days'
    END AS stay_range,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY stay_range
ORDER BY MIN(Length_of_Stay_Days);
SELECT
    DATE_FORMAT(Claim_Date, '%Y-%m') AS claim_month,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY claim_month
ORDER BY claim_month;
SELECT
    YEAR(Claim_Date) AS claim_year,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY YEAR(Claim_Date)
ORDER BY claim_year;
SELECT
    YEAR(Claim_Date) AS claim_year,
    COUNT(*) AS total_claims,
    ROUND(AVG(Claim_Amount), 2) AS avg_claim_amount,
    ROUND(SUM(Claim_Amount), 2) AS total_claim_amount
FROM health_claims
GROUP BY YEAR(Claim_Date)
ORDER BY claim_year;
SELECT
    CASE
        WHEN Deductible_Amount < 1000 THEN 'Below 1K'
        WHEN Deductible_Amount < 2000 THEN '1K-2K'
        WHEN Deductible_Amount < 3000 THEN '2K-3K'
        WHEN Deductible_Amount < 4000 THEN '3K-4K'
        ELSE '4K+'
    END AS deductible_range,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY deductible_range
ORDER BY MIN(Deductible_Amount);
SELECT
    CASE
        WHEN CoPay_Amount < 200 THEN 'Below 200'
        WHEN CoPay_Amount < 400 THEN '200-399'
        WHEN CoPay_Amount < 600 THEN '400-599'
        WHEN CoPay_Amount < 800 THEN '600-799'
        ELSE '800+'
    END AS copay_range,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY copay_range
ORDER BY MIN(CoPay_Amount);
SELECT
    Provider_State,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Provider_State
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_percentage DESC;
SELECT
    Service_Type,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(SUM(
        CASE
            WHEN Is_Fraudulent = 1 THEN Claim_Amount
            ELSE 0
        END
    ), 2) AS fraudulent_claim_amount
FROM health_claims
GROUP BY Service_Type
ORDER BY fraudulent_claim_amount DESC;
SELECT
    Provider_Type,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(SUM(
        CASE
            WHEN Is_Fraudulent = 1 THEN Claim_Amount
            ELSE 0
        END
    ), 2) AS fraudulent_claim_amount
FROM health_claims
GROUP BY Provider_Type
ORDER BY fraudulent_claim_amount DESC;
SELECT
    Claim_ID,
    Patient_ID,
    Hospital_ID,
    Provider_Type,
    Provider_Specialty,
    Service_Type,
    Claim_Amount
FROM health_claims
WHERE Is_Fraudulent = 1
ORDER BY Claim_Amount DESC
LIMIT 10;
SELECT
    Provider_Type,
    Provider_Specialty,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Provider_Type, Provider_Specialty
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_percentage DESC
LIMIT 10;
SELECT
    Provider_Type,
    Provider_Specialty,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage,
    ROUND(SUM(
        CASE
            WHEN Is_Fraudulent = 1 THEN Claim_Amount
            ELSE 0
        END
    ), 2) AS fraudulent_claim_amount
FROM health_claims
GROUP BY Provider_Type, Provider_Specialty
HAVING COUNT(*) >= 100
ORDER BY fraudulent_claim_amount DESC
LIMIT 10;
SELECT
    Provider_Type,
    Service_Type,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate_percentage
FROM health_claims
GROUP BY Provider_Type, Service_Type
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_percentage DESC
LIMIT 10;
WITH provider_fraud AS (
    SELECT
        Provider_Type,
        COUNT(*) AS total_claims,
        SUM(Is_Fraudulent) AS fraudulent_claims,
        ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate
    FROM health_claims
    GROUP BY Provider_Type
)

SELECT *
FROM provider_fraud
WHERE fraud_rate > 25
ORDER BY fraud_rate DESC;
SELECT
    Provider_Specialty,
    COUNT(*) AS total_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate,
    RANK() OVER (
        ORDER BY AVG(Is_Fraudulent) DESC
    ) AS fraud_rank
FROM health_claims
GROUP BY Provider_Specialty;
SELECT
    Provider_Specialty,
    ROUND(
        SUM(CASE 
            WHEN Is_Fraudulent = 1 THEN Claim_Amount 
            ELSE 0 
        END), 2
    ) AS fraud_amount,

    DENSE_RANK() OVER (
        ORDER BY SUM(
            CASE 
                WHEN Is_Fraudulent = 1 THEN Claim_Amount 
                ELSE 0 
            END
        ) DESC
    ) AS financial_risk_rank

FROM health_claims
GROUP BY Provider_Specialty;
SELECT *
FROM health_claims
WHERE Claim_Amount > (
    SELECT AVG(Claim_Amount)
    FROM health_claims
);
SELECT COUNT(*) AS above_average_claims
FROM health_claims
WHERE Claim_Amount > (
    SELECT AVG(Claim_Amount)
    FROM health_claims
);
SELECT
    COUNT(*) AS above_avg_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate
FROM health_claims
WHERE Claim_Amount > (
    SELECT AVG(Claim_Amount)
    FROM health_claims
);
WITH monthly_claims AS (
    SELECT
        DATE_FORMAT(Claim_Date, '%Y-%m') AS claim_month,
        COUNT(*) AS total_claims
    FROM health_claims
    GROUP BY claim_month
)

SELECT
    claim_month,
    total_claims,
    LAG(total_claims) OVER (ORDER BY claim_month) AS previous_month_claims
FROM monthly_claims;
WITH monthly_claims AS (
    SELECT
        DATE_FORMAT(Claim_Date, '%Y-%m') AS claim_month,
        COUNT(*) AS total_claims
    FROM health_claims
    GROUP BY claim_month
),
monthly_comparison AS (
    SELECT
        claim_month,
        total_claims,
        LAG(total_claims) OVER (ORDER BY claim_month) AS previous_month_claims
    FROM monthly_claims
)

SELECT
    claim_month,
    total_claims,
    previous_month_claims,
    total_claims - previous_month_claims AS claim_change
FROM monthly_comparison;
WITH monthly_claims AS (
    SELECT
        DATE_FORMAT(Claim_Date, '%Y-%m') AS claim_month,
        COUNT(*) AS total_claims
    FROM health_claims
    GROUP BY claim_month
),
monthly_comparison AS (
    SELECT
        claim_month,
        total_claims,
        LAG(total_claims) OVER (ORDER BY claim_month) AS previous_month_claims
    FROM monthly_claims
)

SELECT
    claim_month,
    total_claims,
    previous_month_claims,
    ROUND(
        (total_claims - previous_month_claims) * 100.0 /
        previous_month_claims, 2
    ) AS monthly_change_percentage
FROM monthly_comparison;
SELECT
    Provider_Specialty,
    Service_Type,
    COUNT(*) AS total_claims,
    SUM(Is_Fraudulent) AS fraudulent_claims,
    ROUND(AVG(Is_Fraudulent) * 100, 2) AS fraud_rate
FROM health_claims
GROUP BY Provider_Specialty, Service_Type
HAVING COUNT(*) >= 50
ORDER BY fraud_rate DESC
LIMIT 10;
SELECT
    Claim_ID,
    Provider_Specialty,
    Claim_Amount,
    ROW_NUMBER() OVER (
        PARTITION BY Provider_Specialty
        ORDER BY Claim_Amount DESC
    ) AS claim_rank
FROM health_claims
WHERE Is_Fraudulent = 1;
WITH ranked_claims AS (
    SELECT
        Claim_ID,
        Provider_Specialty,
        Claim_Amount,
        ROW_NUMBER() OVER (
            PARTITION BY Provider_Specialty
            ORDER BY Claim_Amount DESC
        ) AS claim_rank
    FROM health_claims
    WHERE Is_Fraudulent = 1
)

SELECT *
FROM ranked_claims
WHERE claim_rank <= 3
ORDER BY Claim_Amount DESC;
WITH ranked_claims AS (
    SELECT
        Claim_ID,
        Provider_Specialty,
        Claim_Amount,
        ROW_NUMBER() OVER (
            PARTITION BY Provider_Specialty
            ORDER BY Claim_Amount DESC
        ) AS claim_rank
    FROM health_claims
    WHERE Is_Fraudulent = 1
)

SELECT *
FROM ranked_claims
WHERE claim_rank <= 3
ORDER BY Provider_Specialty, claim_rank;
SELECT
    Claim_ID,
    Provider_Specialty,
    Claim_Amount,
    ROUND(
        AVG(Claim_Amount) OVER (
            PARTITION BY Provider_Specialty
        ), 2
    ) AS specialty_avg_claim_amount
FROM health_claims
WHERE Is_Fraudulent = 1;
WITH specialty_avg AS (
    SELECT
        Claim_ID,
        Provider_Specialty,
        Claim_Amount,
        AVG(Claim_Amount) OVER (
            PARTITION BY Provider_Specialty
        ) AS specialty_avg_claim_amount
    FROM health_claims
    WHERE Is_Fraudulent = 1
)

SELECT
    Claim_ID,
    Provider_Specialty,
    Claim_Amount,
    ROUND(specialty_avg_claim_amount, 2) AS specialty_avg_claim_amount
FROM specialty_avg
WHERE Claim_Amount > specialty_avg_claim_amount
ORDER BY Claim_Amount DESC;
WITH specialty_avg AS (
    SELECT
        Claim_ID,
        Provider_Specialty,
        Claim_Amount,
        AVG(Claim_Amount) OVER (
            PARTITION BY Provider_Specialty
        ) AS specialty_avg_claim_amount
    FROM health_claims
    WHERE Is_Fraudulent = 1
)

SELECT
    Claim_ID,
    Provider_Specialty,
    ROUND(Claim_Amount, 2) AS claim_amount,
    ROUND(specialty_avg_claim_amount, 2) AS specialty_avg,
    ROUND(
        Claim_Amount - specialty_avg_claim_amount,
        2
    ) AS amount_above_average
FROM specialty_avg
WHERE Claim_Amount > specialty_avg_claim_amount
ORDER BY amount_above_average DESC
LIMIT 10;
WITH specialty_avg AS (
    SELECT
        Claim_ID,
        Provider_Specialty,
        Claim_Amount,
        AVG(Claim_Amount) OVER (
            PARTITION BY Provider_Specialty
        ) AS specialty_avg_claim_amount
    FROM health_claims
    WHERE Is_Fraudulent = 1
)

SELECT
    Claim_ID,
    Provider_Specialty,
    ROUND(
        ((Claim_Amount - specialty_avg_claim_amount)
        / specialty_avg_claim_amount) * 100,
        2
    ) AS percent_above_specialty_avg
FROM specialty_avg
WHERE Claim_Amount > specialty_avg_claim_amount
ORDER BY percent_above_specialty_avg DESC
LIMIT 10;
WITH overall_fraud AS (
    SELECT AVG(Is_Fraudulent) * 100 AS overall_rate
    FROM health_claims
),
specialty_fraud AS (
    SELECT
        Provider_Specialty,
        COUNT(*) AS total_claims,
        AVG(Is_Fraudulent) * 100 AS specialty_rate
    FROM health_claims
    GROUP BY Provider_Specialty
)

SELECT
    Provider_Specialty,
    total_claims,
    ROUND(specialty_rate, 2) AS specialty_fraud_rate,
    ROUND(overall_rate, 2) AS overall_fraud_rate
FROM specialty_fraud
CROSS JOIN overall_fraud
WHERE specialty_rate > overall_rate
ORDER BY specialty_rate DESC;
WITH monthly_claims AS (
    SELECT
        DATE_FORMAT(Claim_Date, '%Y-%m') AS claim_month,
        COUNT(*) AS total_claims
    FROM health_claims
    GROUP BY claim_month
)

SELECT
    claim_month,
    total_claims,
    LEAD(total_claims) OVER (
        ORDER BY claim_month
    ) AS next_month_claims
FROM monthly_claims;








