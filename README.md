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

  [Table showing retiring employees but containing duplicate rows](Queries/retirement_titles.PNG)

2. The query contains all the titles that employees have acquired while working at Pewlett-Hackard over the years. This can result in duplicate information since some employees could appear several times in the titles data; therefore, the number of retiring employees in the table above (133,776) is larger than we need.  So I filtered it The table includes employee number, first name, last name, title, from-date and to-date. This new query returned 90,398 rows (employees).

 [Table showing retiring employees without duplicate rows](Queries/unique_titles.PNG) 

This new table displays a list of employees who expected to retire in the next few years based on their birthdate alone
In the table each employee is listed only once using their most recent title.

This query contained the same data as the query above with addition of using the DISTINCT ON clause that kept only unique rows. To ensure that most recent values are kept, I used the ORDER BY clause to sort the data by descending order on the to_date column. In this case the most recent title was listed first, and after running the query the duplicates listed after the first appearance of the same employees were removed.

3. Now, I created a query using GROUP BY with COUNT() to get the sum of the number of retiring employees for each job title. The query returns a table with 7 rows, for the 7 different job titles currently held by employees expected to retire.   The number of employees expected to retire is 90,398 people, mostly senior engineers and senior staff positions.

[Table showing the count of job titles held by retiring employees ](Queries/retiring_titles.PNG) 

4. Because so many employees might be retiring soon, the company wants another group of older employees (born in 1965 and now age 58), to begin training replacements for retiring employees.  To find the required employees, all selected by birthdate in 1965. This query returns 1,549 rows, meaning that number of employees fit the criteria of being a current employee born in the year 1965. Certainly that is not nearly enough mentors to replace the number of employees expected to retire.  

The table contains employee number, first name, last name, birth date, from date, to date and title.
The table displays a list of employees who is eligible for the mentorship program.

[Table showing employees eligible by birthdate to mentor ](Queries/mentorship_eligiblity.PNG ) 


## Summary
Since the company is preparing for its expected "silver tsunami, " planning is essential, especially when such a large number of the employees might choose to retire in the next few years; in addition many of those expected to retire are currently in senior roles in the company. My analysis above gives good insight about the number of the employees (based on birthdate alone), who are expected to retire soon. However, without knowing which departments retiring senior level employees are leading, it is difficult for the company to plan. This is especailly true since some areas of the company might be more profitable than other locations. 

In order to retrieve department name information, I merged the departments table with the retirement_titles table, using an inner join to get the intersection of the data. After removing the duplicates, with the DISTINCT ON clause, I got the following: 

[Table showing retiring employees with their departments ](Queries/dept_retiring_titles.png) 


How many roles will need to be filled as the "silver tsunami" begins to make an impact?
The table with retirement titles contains all the information about the employees that are expected to retire in the next few years. To get the number of positions that will be open during this time, I ran additional query to count the number of employees that are expected to retire per department. We want to know which departments are most affected; and this new query gives more precise numbers showing what each department can expect in terms of the number of retiring employees and how many roles might need to be filled.


[retiring employees counted by title and department](Queries/dept_titles_count.png) 


Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett-Hackard employees?
To ensure that are enough qualified staff for training at Pewlett-Hackard I ran a query with an additional filter, that returns only employees with senior in their job titles, assuming that those are most qualified to be mentors. From the table we can see how many such employees there are in each department to train next group of employees, assuming everyone works at the company until retirement age and that age is the main determining factor of when a person will retire.




