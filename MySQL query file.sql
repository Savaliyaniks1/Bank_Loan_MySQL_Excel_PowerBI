create table bank_loan_data
(

 id int,
 address_state varchar(50),
 application_type varchar(50),
 emp_length varchar(50),
 emp_title varchar(50),
 grade varchar(50),
 home_ownership varchar(50),
 issue_date date,
 last_credit_pull_date date,
 last_payment_date date,
 loan_status varchar(50),
 next_payment_date date,
 member_id int,
 purpose varchar(50),
 sub_grade varchar(50),
 term varchar(50),
 verification_status varchar(50),
 annual_income int,
 dti float,
 installment float,
 int_rate float,
 loan_amount int,
 total_acc int,
 total_payment int
 );

-- Total Loan Applications

select count(*) as Total_application from bank_loan_data;

-- MTD Total Loan Applications

select count(*) as MTD_loan_application
from bank_loan_data
where month(issue_date) = 12;

-- PMTD Total Loan Applications

select count(*) as PMTD_loan_application
from bank_loan_data
where month(issue_date) = 11;

-- Total Funded Amount

select sum(loan_amount) as Total_Funded_Amount
from bank_loan_data;

-- MTD Total Funded Amount

select sum(loan_amount) as MTD_Total_Funded_Amount
from bank_loan_data
where month(issue_date) = 12;

-- PMTD Total Funded Amount

select sum(loan_amount) as PMTD_Total_Funded_Amount
from bank_loan_data
where month(issue_date) = 11;

-- Total Amount Received

select sum(total_payment) AS Total_Amount_Collected
from bank_loan_data;

-- MTD Total Amount Received

select sum(total_payment) AS MTD_Total_Amount_Collected
from bank_loan_data
where month(issue_date) = 12;

-- PMTD Total Amount Received

select sum(total_payment) AS PMTD_Total_Amount_Collected
from bank_loan_data
where month(issue_date) = 11;

-- Average Interest Rate

select round(Avg(int_rate)*100,2) AS Avg_Int_Rate
from bank_loan_data; 

-- MTD Average Interest Rate

select round(Avg(int_rate)*100,2) AS MTD_Avg_Int_Rate
from bank_loan_data
where month(issue_date) = 12; 
 
-- PMTD Average Interest Rate

select round(Avg(int_rate)*100,2) AS PMTD_Avg_Int_Rate
from bank_loan_data
where month(issue_date) = 11;

-- Average DTI

select round(avg(dti)*100,2) as Avg_DTI
from bank_loan_data;

-- MTD Average DTI

select round(avg(dti)*100,2) as MTD_Avg_DTI
from bank_loan_data
where month(issue_date) = 12;

-- PMTD Average DTI

select round(avg(dti)*100,2) as PMTD_Avg_DTI
from bank_loan_data
where month(issue_date) = 11;

-------------------------------------------------- GOOD LOAN ISSUED -----------------------------------------------------------------

-- Good Loan Percentage

select 
    (count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then 
	 id end)*100) /
     count(id) as Good_Loan_Percentage
from bank_loan_data;


-- Good Loan Application

select count(id) AS Good_Loan_Application
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- Good Loan Funded Amount

select sum(loan_amount) as Good_Loan_Funded_Amount 
from bank_loan_data
Where loan_status = 'Fully paid' or loan_status = 'Current';

-- Good Loan Amount Received

select sum(total_payment) as Good_Loan_Amount_Received 
from bank_loan_data
Where loan_status = 'Fully paid' or loan_status = 'Current';

-------------------------------------------------- Bad Loan amount Received -------------------------------------------------------------

-- Bad Loan Percentage

select 
    (count(case when loan_status = 'Charged Off' then id 
     end)*100)/
	 count(id) AS Bad_Loan_Percentage
from bank_loan_data;

-- Bad Loan Application

select count(id) As Bad_Loan_Application
from bank_loan_data
where loan_status = 'Charged Off';

-- Bad Loan Funded Amount

select sum(loan_amount) as Bad_Loan_Funded_Amount 
from bank_loan_data
where loan_status = 'Charged Off';

-- Bad Loan Amount Received

select sum(total_payment) AS Bad_Loan_Amount_Received
from bank_loan_data
where loan_status = 'Charged Off';


-------------------------------------------------- Loan Status ------------------------------------------------------


select 
     loan_status,
     count(id) AS Loan_Count,
     Sum(total_payment) AS Total_Amount_Received,
     Sum(loan_amount) AS Total_Funded_Amount,
     Avg(int_rate*100) AS Interest_Rate,
     Avg(dti*100) AS DTI
     
from bank_loan_data
group by loan_status
order by Total_Amount_Received desc;


-- MTD Loan Status

select 
    loan_status,
    sum(total_payment) AS MTD_Total_Amount_Received,
    SUm(loan_amount) AS MTD_Total_Funded_Amount
from bank_loan_data
where month(issue_date) = 12
group by loan_status;


----------------------------------------------------- Bank Loan Report | Overview --------------------------------------------------------

-- Month 


select 
	month(issue_date) AS Month_number,
      monthname(issue_date) AS Month_name,
      count(id) AS Total_Loan_Applications,
      sum(loan_amount) AS Total_Funded_Amount,
      sum(total_payment) AS Total_Amount_Received

from bank_loan_data
group by monthname(issue_date), month(issue_date)
order by Month_number;

-- State

select 
     address_state AS State,
     count(id) AS Total_Loan_Applications,
     sum(loan_amount) AS Total_Funded_Amount,
     sum(total_payment) AS Total_Amount_Received

from bank_loan_data
group by address_state
order by address_state;


-- TERM


select 
        term AS Term,
        count(id) AS Total_Loan_Applications,
        sum(loan_amount) AS Total_Funded_Amount,
        sum(total_payment) AS Total_Amount_Received
from bank_loan_data
group by term
order by term;


-- EMPLOYEE LENGTH

select 
     emp_length AS Employee_Length,
     count(id) AS Total_Loan_Application,
     sum(loan_amount) AS Total_Funded_Amount,
     sum(total_payment) AS Total_Amount_Received
from bank_loan_data
group by emp_length
order by emp_length;


-- PURPOSE

select 
     purpose AS PURPOSE,
     count(id) AS Total_Loan_Application,
     sum(loan_amount) AS Total_Funded_Amount,
     sum(total_payment) AS Total_Amount_Received
from bank_loan_data
group by purpose
order by purpose;

-- HOME OWNERSHIP

select 
     home_ownership AS Home_Ownership,
     count(id) AS Total_Loan_Application,
     sum(loan_amount) AS Total_Funded_Amount,
     sum(total_payment) AS Total_Amount_Received
from bank_loan_data
group by home_ownership
order by home_ownership;

-- Grade wise Home ownership filtering
select 

     home_ownership AS Home_Ownership,
     count(id) AS Total_Loan_Application,
     sum(loan_amount) AS Total_Funded_Amount,
     sum(total_payment) AS Total_Amount_Received
from bank_loan_data
where grade = 'A'
group by home_ownership
order by home_ownership;