use healthcare_data;
select * from ocd_patient_dataset;

-- count female vs male that have ocd & average obession score by gender
SELECT
Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM ocd_patient_dataset
Group By 1
Order by 2;
 
-- % by gender

with data as (
SELECT
Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM ocd_patient_dataset
Group By 1
Order by 2
)
select
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_female,

    round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_male

from data
;

-- count & average obsession score by ethnicities that have OCD

select Ethnicity, count(`Y-BOCS Score (Obsessions)`) as obs_count,
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
from ocd_patient_dataset
group by Ethnicity
order by obs_count;

-- number of people daignosed Month of month (First convert text to date data type in date)

alter table ocd_patient_dataset
modify `OCD Diagnosis Date` date;

select
date_format(`OCD Diagnosis Date`, '%Y-%m-01') as month,
count(`Patient ID`) as patient_count
from ocd_patient_dataset
group by 1
order by 1;

-- most common obsession type & its respective average

select `Obsession Type`, count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
from ocd_patient_dataset
group by 1
order by 2;

-- What is the most common Compulsion type (Count) & it's respective Average Obsession Score

select `Compulsion Type`, count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2)
from ocd_patient_dataset
group by 1
order by 2;



























