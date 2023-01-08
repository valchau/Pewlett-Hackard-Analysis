--Get retiring employees by birthdate and title
SELECT  empl.emp_no,
	empl.first_name, 
	empl.last_name, 
	title.title, 
	title.from_date, 
	title.to_date	
INTO retirement_titles
FROM employees as empl
INNER JOIN titles as title
ON (empl.emp_no = title.emp_no)
	WHERE (empl.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY empl.emp_no;


-- yes got the table and data! Finally.
select * from retirement_titles;
	
-- Drop duplicate records for retiring employees to clean up data
SELECT DISTINCT ON (retire.emp_no) 
	retire.emp_no,
	retire.first_name,
	retire.last_name,
	retire.title
INTO unique_titles
FROM retirement_titles as retire
ORDER BY retire.emp_no, retire.to_date DESC;

-- got the table and the data!
select * from unique_titles;

-- Count the number of retiring employees by most recent job title 
SELECT COUNT(uniq.title), uniq.title
INTO retiring_titles
FROM unique_titles as uniq
GROUP BY uniq.title
ORDER BY count DESC;

select * from retiring_titles;

--Get employees eligible for the mentorship program based on birthdate.
SELECT DISTINCT ON (empl.emp_no)
	empl.emp_no,
	empl.first_name, 
	empl.last_name, 
	empl.birth_date,
	dempl.from_date,
	dempl.to_date,
	title.title
INTO mentorship_eligibilty
FROM employees as empl
INNER JOIN dept_emp as dempl
ON (empl.emp_no = dempl.emp_no)
INNER JOIN titles as title
ON (empl.emp_no = title.emp_no)
WHERE (empl.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (dempl.to_date = '9999-01-01')
ORDER BY empl.emp_no, title.from_date DESC;

select * from mentorship_eligibilty;
