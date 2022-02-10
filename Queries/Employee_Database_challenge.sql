---MOd-7 Challenge
--#1 Number of Retirees by title

--FIRST STEP - PART ONE

SELECT e.emp_no,
    e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- SECOND STEP - PART ONE

-- Use Dictinct with Order by to remove duplicate rows

SELECT DISTINCT ON (r.emp_no) r.emp_no,
	r.first_name,
	r.last_name,
	r.title
INTO unique_titles
FROM retirement_titles AS r
WHERE (r.to_date = '9999-01-01')
ORDER BY r.emp_no, r.to_date DESC;



-- THIRD STEP - PART ONE

-- Get Count of retirees for each job title

SELECT COUNT (u.emp_no), u.title
INTO retiring_titles
FROM unique_titles AS u
GROUP BY u.title
ORDER BY COUNT DESC;


---MOd-7 Challenge
--#2 Employees Eligible for Mentoring 

SELECT DISTINCT ON (emp_no)
	e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

