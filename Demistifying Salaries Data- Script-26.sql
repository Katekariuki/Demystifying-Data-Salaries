--work_year - The year the salary was paid.
--experience_level - Employee experience level:
		--EN: Entry-level / Junior
		--MI: Mid-level / Intermediate
		--SE: Senior / Expert
		--EX: Executive / Director
		--employment_type - Employment type:
		--PT: Part-time
		--FT: Full-time
		--CT: Contract
		--FL: Freelance
--job_title - The job title during the year.
--salary - Gross salary paid (in local currency).
--salary_currency - Salary currency (ISO 4217 code).
--salary_in_usd - Salary converted to USD using average yearly FX rate.
--employee_residence - Employee's primary country of residence (ISO 3166 code).
--remote_ratio - Percentage of remote work:
		--0: No remote work (<20%)
		--50: Hybrid (50%)
		--100: Fully remote (>80%)
--company_location - Employer's main office location (ISO 3166 code).
--company_size - Company size:
		--S: Small (<50 employees)
		--M: Medium (50–250 employees)
		--L: Large (>250 employees)
---Challenge 
set search_path to demistifying_data_salaries
select * from salaries;

---Checking data types
select * from information_schema."columns"
where table_schema='demistifying_data_salaries'
and table_name='salaries';

--How many full-time employees based in the US work 100% remotely?
select count(*) as US_fulltime_remote_employees
from salaries
where employment_type='FT'
and employee_residence = 'US'
and remote_ratio = 100

--What is the average salary (in USD) for Data Scientists and Data Engineers? Which role earns more on average?
select job_title,(avg(salary_in_usd )::numeric(10,2))as average_USDsalary
from salaries
where job_title='Data Scientist'
or job_title='Data Engineer'
group by 1

---How many records are in the dataset, and what is the range of years covered?
select count(*)
from salaries;
--year range
select min(work_year) as earliest_year, max(work_year) as latest_year
from salaries

---LEVEL 2
--Create a bar chart displaying the top 5 job titles with the highest average salary (in USD).
select job_title,(avg(salary_in_usd)::numeric(10,2)) as average_salary
from salaries
group by 1
order by average_salary desc
limit 5;


---Compare the average salaries for employees working remotely 100%, 50%, and 0%. What patterns or trends do you observe?
select remote_ratio,(avg(salary_in_usd)::numeric(10,2)) as average_salary
from salaries
group by 1
order by remote_ratio;

---salary distribution (in USD) across company sizes (S, M, L). Which company size offers the highest average salary?
select company_size,(avg(salary_in_usd)::numeric(10,2)) as average_salary
from salaries
where company_size in ('S','M','L')
group by 1







