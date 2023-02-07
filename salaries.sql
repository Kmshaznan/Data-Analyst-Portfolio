show tables;

select *
from ds_salaries;

select employee_residence, count(employment_id) 
from ds_salaries
group by 1
order by 2 desc;

#view highest salary in each job title
select job_title, max(salary_in_usd) as highest_salary
from ds_salaries
group by 1
order by 2 desc;

#view total salary of each job title in every year
select work_year,job_title, sum(salary_in_usd) as total_salary
from ds_salaries
group by 1,2
order by 1, 3 DESC;	

#which experience level have highest average salary 
select experience_level, round(avg(salary_in_usd),2)
from ds_salaries
group by 1
order by 2 desc;

#view job title where the salary is higher than average salary
select job_title, avg(salary_in_usd)
from ds_salaries
group by 1
having avg(salary_in_usd) >
	(select avg(salary_in_usd) from ds_salaries)
order by 2 desc;
    
#top 3 job title with highest average salary in 2022
select job_title, average_salary
from (select job_title, round(avg(salary_in_usd),2) as average_salary
		from ds_salaries 
        where work_year = '2022'
        group by 1) as avg_salary
order by 2 desc
limit 3;

#view the highest salary of each job title in each residence, each year
select 
	work_year, 
    job_title, 
    employee_residence, 
    sum(salary_in_usd) as total_salary
from ds_salaries
group by 1,2,3
order by 1,3,4 desc;