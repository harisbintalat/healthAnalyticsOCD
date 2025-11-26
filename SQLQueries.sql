
-- 1. Count & Pecentage of males and females that have OCD & Average Obsession Score by Gender

-- Count & Perentage of M & F that have OCD
WITH dataCTE AS ( --CTE
    SELECT
    Gender, 
    COUNT(Patient_id) AS totalCount
    FROM ocd_patient_dataset
    GROUP BY Gender
),
gender_totals AS ( --SUBQUERY
    SELECT
        SUM(CASE WHEN Gender = 'Female' THEN totalCount ELSE 0 END) AS count_female,
        SUM(CASE WHEN Gender = 'Male' THEN totalCount ELSE 0 END) AS count_male
    FROM dataCTE
)
SELECT
    count_female,
    count_male,
    CAST(count_female AS FLOAT) / (count_female + count_male) * 100 AS pct_female,
    CAST(count_male AS FLOAT) / (count_female + count_male) * 100 AS pct_male
FROM gender_totals;

--Avg Obession Score
SELECT 
    Gender,
    COUNT(Patient_ID) as patientCount,
    AVG(Y_BOCS_Score_Obsessions) as AvgObsessionScore
FROM
    ocd_patient_dataset

GROUP BY
    Gender



-- 2. Number of people by Ethnicity that have OCD & thier Average Obsession Score 

SELECT
Ethnicity,
COUNT(Y_BOCS_Score_Obsessions) AS ObessionCountByEthnicity,
ROUND(AVG(CAST(Y_BOCS_Score_Obsessions AS FLOAT)),2) AS ObessionAvgByEthnicity
FROM
ocd_patient_dataset

GROUP BY
Ethnicity


-- 3. Number of people diagnosed by Month

SELECT 
    sub.monthDates,
    COUNT(*) AS patientCountByMonth
    FROM (
    SELECT
        DATEFROMPARTS(YEAR(OCD_Diagnosis_Date), MONTH(OCD_Diagnosis_Date), 1) AS monthDates
        FROM ocd_patient_dataset
    ) as sub

GROUP BY 
   sub.monthDates
ORDER BY 
    monthDates;


-- 4. What is the most common Obsession type (count) & It's respective Average Obsession Score

SELECT
Obsession_Type,
COUNT(Obsession_Type) AS CommonObsessionType,
ROUND(AVG(CAST(Y_BOCS_Score_Obsessions AS FLOAT)),2) AS AvgScorePerObsession

FROM
ocd_patient_dataset

GROUP BY
Obsession_Type

ORDER BY
1


-- 5. What is the most common Complusion type (Count) & It's respective Average Obsession Score
SELECT
Compulsion_Type,
COUNT(Compulsion_Type) AS CommonCompulsionnType,
ROUND(AVG(CAST(Y_BOCS_Score_Compulsions AS FLOAT)),2) AS AvgScorePerCompulsion

FROM
ocd_patient_dataset

GROUP BY
Compulsion_Type

ORDER BY
1


--SELECT * FROM ocd_patient_dataset