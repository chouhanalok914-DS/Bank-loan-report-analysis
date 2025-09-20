
-- BANK LOAN REPORT | SUMMARY
-- 1. KPI’s:
-- Total Loan Applications
-- Month-to-Date (MTD) Total Amount Received refers to the total sum of money received within the current month up to the present date. 

SELECT * FROM financial_loan;

SELECT COUNT(id) AS Total_Applications FROM financial_loan;
 
-- MTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 12;
 
-- PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 11;

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan;
 
-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 12;
 
-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 11;
 
-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan;
 
-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 12;
 
-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 11;
 
-- Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial_loan;
 
-- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 12;
 
-- PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 11;
 
-- Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan;
 
-- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 12 ;
 
-- PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM financial_loan
WHERE MONTH(str_to_date(issue_date,'%Y-%m-%d')) = 11;

-- 2. GOOD LOAN ISSUED
-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan;
 

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
 
-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


-- 3. BAD LOAN ISSUED
-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan
WHERE loan_status = 'Charged Off';
 
-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Charged Off';
 
-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Charged Off';
 
-- 4. LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        ROUND(AVG(int_rate * 100), 2) AS Interest_Rate,
        ROUND(AVG(dti * 100), 2) AS DTI
    FROM
        financial_loan
    GROUP BY
        loan_status ;
        
-- Loan Status MTD 
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status ;





-- BANK LOAN REPORT | OVERVIEW


-- MONTH
SELECT 
	MONTH(issue_date) AS Month_Number,
    Monthname(issue_date) AS Month_name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), Monthname(issue_date)
ORDER BY MONTH(issue_date) ;



-- STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;
 

-- TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received,
    ROUND(Avg(int_rate)*100, 2) AS Interest_Rate
FROM financial_loan
GROUP BY term
ORDER BY term ;


-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length ;
 
-- PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received,
    ROUND(Avg(int_rate)*100, 2) AS Interest_Rate
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;
  

-- See the results when we hit the Grade A in the filters for dashboards.
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;



-- MoM Loan Application growth
SELECT MONTH(issue_date) AS Month, COUNT(id) AS Total_Application, 
(COUNT(id) - LAG(COUNT(id)) OVER(ORDER BY MONTH(issue_date)))*100 / COUNT(id) AS MoM_Applications
FROM financial_loan
GROUP BY MONTH(issue_date);

-- Mom Loan Amount Disbursed growth
SELECT MONTH(issue_date) AS MONTH, Sum(loan_amount), 
(Sum(loan_amount) - LAG(Sum(loan_amount)) OVER(ORDER BY MONTH(issue_date)))*100 / Sum(loan_amount) AS MoM_Loan_Disbursed
FROM financial_loan
GROUP BY MONTH(issue_date);

-- Interest rate for various subgrade and grade overall
SELECT distinct grade, 
ROUND(AVG(int_rate) OVER(partition by grade)*100, 2) AS 'grade_interest_rate',
sub_grade, 
ROUND(AVG(int_rate) OVER(PARTITION BY sub_grade)*100, 2) AS 'sub_grade_interest_rate'
FROM financial_loan;
