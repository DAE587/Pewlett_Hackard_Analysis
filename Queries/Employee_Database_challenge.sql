---Mod-7 Challenge
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


--Part three explaintion how many jobs need to be replaced each year.
-- Get Count of retirees by year

SELECT EXTRACT(YEAR FROM u.birth_date), COUNT (u.emp_no) AS number_of_retirees
INTO retiring_titles_year
FROM unique_titles_year AS u
GROUP BY EXTRACT(YEAR FROM u.birth_date)





---Mod-7 Challenge
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



---Mod-7 Challenge
--#3 Additional Queries to answer questions
--question #1 How many roles need to be filled as the silver tsunami starts

--Part three explaintion how many jobs need to be replaced each year.
-- Get Count of retirees by year

SELECT EXTRACT(YEAR FROM u.birth_date), COUNT (u.emp_no) AS number_of_retirees
INTO retiring_by_year
FROM unique_titles_year AS u
GROUP BY EXTRACT(YEAR FROM u.birth_date)


-- --question #2 Are there enough mentors for mentees by department

--Step 1
--determine how many mentees per department
SELECT DISTINCT ON (emp_no)
	e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.dept_no,
	de.from_date,
	de.to_date,
	d.dept_name
INTO mentorship_eligibility_dept
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT (med.emp_no), med.dept_name
INTO mentees_by_dept
FROM mentorship_eligibility_dept AS med
GROUP BY med.dept_name
ORDER BY COUNT DESC;


--Step 2
--determine how many retirees per department
SELECT DISTINCT ON (emp_no)
	e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.dept_no,
	de.from_date,
	de.to_date,
	d.dept_name
INTO mentors_avalable
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT (ma.emp_no), ma.dept_name
INTO mentors_avalable_dept
FROM mentors_avalable AS ma
GROUP BY ma.dept_name
ORDER BY COUNT DESC;




