-- CREATE TABLE departments(
-- 	dept_no varchar,
-- 	dept_name varchar
-- 						);
-- CREATE TABLE department_employees(
-- 	emp_no int,
-- 	dept_no varchar
-- 						);
-- CREATE TABLE department_manager(
-- 	dept_no varchar,
-- 	emp_no int
-- 						);
-- CREATE TABLE employees(
-- 	emp_no int,
-- 	emp_title_id varchar,
-- 	birth_date date,
-- 	first_name varchar,
-- 	last_name varchar,
-- 	sex varchar,
-- 	hire_date date
-- 						);
-- CREATE TABLE salaries(
-- 	emp_no int,
-- 	salary int
-- 						);
-- CREATE TABLE titles(
-- 	title_id varchar,
-- 	title varchar
-- 						);

select *
from department_employees
limit 100;
select *
from department_manager
limit 100;
select *
from departments
limit 100;
select *
from employees
limit 100;
select *
from salaries
limit 100;
select *
from titles
limit 100;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
select
	s.emp_no as "employee_number",
	last_name,
	first_name,
	sex,
	salary
from employees as e
	inner join salaries as s
		on e.emp_no = s.emp_no
;
--List first name, last name, and hire date for employees who were hired in 1986.
select
	first_name,
	last_name,
	hire_date
from employees
where hire_date >= '1986-01-01' and hire_date <= '1986-12-31';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- create view test as
-- select dept.dept_no, dept_name, emp_no
-- from departments as dept
-- 	join department_manager as dept_m
-- 		on dept.dept_no = dept_m.dept_no;
select
	dept_no,
	dept_name,
	e.emp_no,
	last_name,
	first_name
from employees as e
	inner join test as t
		on e.emp_no = t.emp_no;
		
--List the department of each employee with the following information: employee number, last name, first name, and department name.
-- create view dept_names_employees as
-- 	select dept_name, emp_no
-- 			from departments as d
-- 				inner join department_employees as de
-- 					on d.dept_no = de.dept_no;

select
	e.emp_no,
	last_name,
	first_name,
	dept_name
from employees as e
	inner join dept_names_employees as dne
		on dne.emp_no = e.emp_no
;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select
	first_name,
	last_name,
	sex
from employees
where first_name = 'Hercules' and last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- create view dept_employees_sales as
-- select emp_no, d.dept_no, dept_name
-- from department_employees as de
-- 	inner join departments as d
-- 		on de.dept_no = d.dept_no
-- where dept_name = 'Sales';
select
	e.emp_no,
	last_name,
	first_name,
	dept_name
from employees as e
	inner join dept_employees_sales as des
		on e.emp_no = des.emp_no
;
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select
	last_name,
	count(last_name) as count_last_names
from employees
group by last_name
order by count_last_names desc;

--

-- create view emp_titles_and_id as
-- select
-- 	emp_no,
-- 	t.title_id,
-- 	t.title
-- from employees as e
-- 	inner join titles as t
-- 		on e.emp_title_id = t.title_id;

select
	eti.title,
	avg(s.salary) as average_salary
from salaries as s
	inner join emp_titles_and_id as eti
		on eti.emp_no = s.emp_no
group by eti.title
order by average_salary desc;