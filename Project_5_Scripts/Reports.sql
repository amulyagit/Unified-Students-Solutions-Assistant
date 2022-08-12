-------------------------- Report 1 : No. of Pickups according to Pickup Location --------------------------
select pickup_location,
count(*)
from pickup
group by pickup_location;



-------------------------- Report 2 : No. of Alumni with Degree - MS Information Systems grouped by Salary Range --------------------------
select salary_range, count(*)
from alumni
where degree_id = 1
group by salary_range;



-------------------------- Report 3 : No. of Alumni with GPA > 3.5 grouped by Salary Range --------------------------
select salary_range, count(*) AS "TOTAL"
from alumni
where gpa > 3.5
group by salary_range;



-------------------------- Report 4 : No. of Alumni who took course DMDD or DWBI grouped by Salary Range --------------------------
select salary_range, count(*)
from VW_ROLE
WHERE course_id = 5010 or course_id = 5011
group by salary_range;



-------------------------- Report 5 : No. of Alumni who took course Data Management for Analytics  grouped by Job Title --------------------------
Select job_title, count(*)
from VW_ROLE
WHERE course_name = 'Data Management for Analytics'
group by job_title;