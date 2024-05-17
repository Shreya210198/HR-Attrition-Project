USE HR_ANALYTICS_CAPSTONE

SELECT * FROM dbo.hr_data

1)

SELECT 
    a.Employee_Number,
    a.Department,
    a.Performance_Rating,
    b.Avg_Performance_Rating,
	CASE
		WHEN a.Performance_Rating>b.Avg_Performance_Rating THEN 'Above'
		ELSE 'Below'
	END AS Rating_Comparison
FROM 
    hr_data AS a
JOIN (
    SELECT 
        Department, 
        AVG(Performance_Rating) AS Avg_Performance_Rating
    FROM 
        hr_data
    GROUP BY 
        Department
) AS b ON a.Department = b.Department;



2)

SELECT Over_Time,
SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) /CAST(COUNT(*) AS DECIMAL(10,2))* 100  AS AttritionPercentage
FROM hr_data
GROUP BY Over_Time
ORDER BY AttritionPercentage DESC;

3)

 SELECT Age,
        Job_Role,
        Performance_Rating,
        Attrition 
FROM hr_data;

4)

SELECT Department,
(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END)*1.0/COUNT(Employee_Count))*100 AS AttritionPercentage
FROM hr_data
GROUP BY Department
ORDER BY AttritionPercentage DESC;

5)

USE HR_ANALYTICS_CAPSTONE;

SELECT * FROM hr_data;


SELECT SUM(CAST(Attrition as float))/SUM(Employee_Count)*100 as Attrition_Rate
FROM hr_data;


CREATE TABLE HR_DATA_Attirtion_Rate (
	Attrition_Rate float);

Insert into HR_DATA_Attirtion_Rate SELECT SUM(CAST(Attrition as float))/SUM(Employee_Count)*100 as Attrition_Rate
FROM hr_data;

UPDATE HR_DATA_Attirtion_Rate
SET Attrition_Rate = (SELECT SUM(CAST(Attrition as float))/SUM(Employee_Count)*100 FROM hr_data)


SELECT * FROM HR_DATA_Attirtion_Rate;


--- Attrition Rate can change on two conditions

-- 1) New Employee Joins - INSERT - TYPICALLY ATTRITION RATE DECREASES
-- 2) Old Employee Leaves - UPDATE - TYPICALLY ATTRITION RATE INCREASES 


--- Old Employee Leaving



CREATE TRIGGER UP_hr_data
ON hr_data
FOR UPDATE
AS 
BEGIN 
	UPDATE HR_DATA_Attirtion_Rate SET Attrition_Rate = (SELECT SUM(CAST(Attrition as float))/SUM(Employee_Count)*100  FROM hr_data)
END ;


UPDATE hr_data
SET Attrition = 0
WHERE Employee_Number  IN (2,5,7,8,10,11,12,13,14,15,16,18,20,21,22,23,24,26,28,30,32,35,36,38,39);

SELECT Attrition
FROM hr_data
WHERE Employee_Number  IN (2,5,7,8,10,11,12,13,14,15,16,18,20,21,22,23,24,26,28,30,32,35,36,38,39);



6)

SELECT Education_Field,
AVG(Hourly_Rate) AS Average_Hourly_Rate
FROM hr_data
GROUP BY education_field
ORDER BY AVG(Hourly_Rate) DESC;














