# Pewlett-Hackard-Analysis
## Purpose
The purpose of this analysis is to prepare Pewlett-Hackard, a company with several thousand employees, for the upcoming “silver tsunami” that is supposedly coming. A large number of employees are expected to begin retiring, according to this case study, at a rapid rate in the next few years and the company wants to be prepared with the retirement packages, open positions and employees’ training. 

In truth, these predictions of boomers retiring massively never occured. Largely because many could not afford to retire and also because people are living longer healthier lives than in the past. In additon, laws passed make is more difficult to force people to retire based on their age alone. So these doomsday predictions never came true. Nevertheless, this case study asks us to assume this would have happened.  The two main tasks are to identify the employees who are expected to retire based on being born between 1952- 1955,  and also separately identify a separate group of employees, all born in 1965, who are to be selected for a mentorship program. 

## The tasks are:

### Who is expected to retire and what job titles do they have: 
We are told to find out who is expected to retire based on the sterotype that birth date means retirement; ignoring other life factors such as disability, caregiving, plus the fact that most people have been changing jobs and employers every 5 years or so for the past 20 years at least.
* We start by dentifying the 'retiring' employees by their birth dates, assuming that employees born between 1952 - 1955 (now ages 68 to 71 years old), are those who are going to retire. 
* The selected employees' names, birth dates, and most current job title, including the to date and from date for the title are selected for further analysis.
* The selected employees might have been at the company long enough to hold several jobs, so the data is trimmed to only present the current job.
* Then the number of retiring employees grouped by title is reported so we understand what job categories are most likely to be open or need to be filled once the employees retire.

### Who is selected for a mentorship program: 
We assume that employees born in the year 1965 (now age 58 years old), are deserving of mentorship. This looks like another lawsuit waiting to happen.
* Identify the employees eligible for participation in the mentorship program by their birthdates, capturing their job titles, names, and the title 'to and from' dates to determine which employees have already left the company. Note that this does not mean the person retired; only that they are no longer working for Pewlett-Hackard.
* Next, because employees can have more than one job at the company, the data is filtered so we only have the employees' most recent job title. 
* Then we get a convenient summary of the job titles of all of the retiring employees so that we can focus on those job titles (it is easier to remember a few job titles than remember the names of all employees expected to retire.
* Determine the number of roles-to-fill grouped by title and department. This does not take into consideration those employees expected to retire.
Determine the number of qualified, retirement-ready employees to mentor the next generation grouped by title and department.

## Data provided
The data is provided in six files, formatted as comma separated data values. We could use Python or other tools to analyze this type of data, but in this case we are using a free open source tool, PostreSQL to create a database and analyze the given data. The given csv files represent:
* employees
* departments
* deparment managers
* department employees
* salaries
* job titles

## Data created
Also in csv files, this analysis created several output results.
* retirement titles - a list of all current employees with birthdates between 1952 and 1955 inclusive, showing all of their job titles and the years they had those jobs
* unique_titles - trims the retirement titles data so that retiring employees are only listed with their most current job title.
* retiring titles - containing a summary of the 7 job titles representing all retiring employees (counted only once), to help us understand what roles the company might need to hire or promote people into - but we would need to know the department too in order to really make this decision since some departments might be slimmed down or expaned in the company's future plans.
* mentorship_eligiblity - this is a file that contains the selected employees whose birthday is during the year 1965. 

## Tools:
QuickDBD to create quick database design for better visualization,
PostreSQL a database system to load, build and host company’s data, and
pgAdmin a GUI, using SQL Language to explore, manipulate and extract the data.
Excel to view the csv files to look at their data, field names and understand the meaning of duplicate rows; these helps determine the primary keys for each table as well as make sense of the task.


## Overview of the Results

1. To retrieve the data about which employees are expected to retire, two database tables were accessed and pertinent fields were merged together to create a new database table,  - employees and titles. I used an inner join clause to get data rows satisfying the AND condition to match employees with their titles and dates. The query was filtered by birth date, following the given instructions, assuming that these birthdates represent employees about to retire in the next few years (even though such employees would be 68 to 71 years old now),  using a WHERE clause to select their birthdates (birth_date BETWEEN '1952-01-01' AND '1955-12-31').

  [Table showing some of the retiring employees](Queries\retirement_titles.PNG)

2. The query contains all the titles that employees have acquired while working at Pewlett-Hackard over the years. This can result in duplicate information since some employees could appear several times in the titles data; therefore, the number of retiring employees (133,776) is larger than we need.  So I filtered it 

The table includes employee number, first name, last name, title, from-date and to-date.
The query returns 90,398 rows.

The table displays a list of employees who expected to retire in the next few years based on their birthdate alone
In the table each employee is listed only once, by their most recent title.


Table with the employee’s data that are retirement-ready without duplicates


Query contains the same data as the query above with addition of distinct_on command that kept only unique values. To ensure that most recent values are kept, I used command ORDER BY rt.emp_no, rt.to_date DESC to sort the data by descending order on the to_date column. In this case the most recent title was listed first, and after running the query the duplicates listed after the first appearance of the same employees were removed.

3. The number of retiring employees grouped by title

The table includes employees’ titles and their sum.
The query returns a cohesive table with 7 rows.
From this table we can quickly see how many employees with certain title will retire in the next few years.


Table with the employee grouped by title

Overview of the code

In order to retrieve this table I used GROUP BY ut.title command, and it is responsible for grouping the rows by titles. Next, I used its corresponding command COUNT (ut.title) that counts how many times specific title appears in the database.

4. The employees eligible for the mentorship program

The table contains employee number, first name, last name, birth date, from date, to date and title.
The query returns 1,549 rows.
The table displays a list of employees who is eligible for the mentorship program.


Table with the employee grouped by title

Overview of the code

To retrieve this data, three tables were merge together: employees, titles and dep_emp with the inner join. The query filters by birth date (that indicates who is eligible for the mentorship program) with the command WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') and to_date to include only current employees. Duplicates were removed by DISTINCT ON (e.emp_no) command. To ensure I got the most recent titles, I used ORDER BY e.emp_no, ti.from_date DESC command.



Summary
As the company is preparing for the upcoming "silver tsunami" a good planning is essential, especially when such a large number of the employees is involved. Reports above give a good insight about the number of the employees that are about to retire and hold specific title. However, I believe that additional break down per department will be beneficial for the company. In this case headquarters can see what to expect in each department separately. In order to retrieve department name information, I merged additional table departments into existing table retirement_titles with the inner join. After removing the duplicates, with DISTINCT ON command, the table was ready to be used for additional queries.



Figure 6: Table with retirement-ready employee’s data with added department name



How many roles will need to be filled as the "silver tsunami" begins to make an impact?
The table retirement titles contains all the information about the employees that are about to retire in the next four years. To get the number of positions that will be open in next four years I ran additional query that breaks down how many staff will retire per department. Since every department will be affected in some way this query gives more precise numbers what each department can expect and how many roles will need to be filled.



Figure 7: Sum of retirement-ready employees group by title and department.


Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett-Hackard employees?
To ensure that are enough qualified staff for training at Pewlett-Hackard I ran a query with additional filter, that returns only employees on higher positions, assuming that those are qualified as mentors. With the command WHERE ut.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager') the results include only staff on higher positions. From the table we can see how many qualified employees are in each department to train next generation.



Figure 8: Sum of qualified, retirement-ready employees group by title and department
