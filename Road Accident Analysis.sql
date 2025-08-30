

--Q: What is the total number of casualties & accidents this year vs last year?

WITH yearly AS (
  SELECT 
    EXTRACT(YEAR FROM accident_date) AS year,
    SUM(number_of_casualties) AS total_casualties,
    COUNT(*) AS total_accidents
  FROM accidents
  GROUP BY 1
)
SELECT * FROM yearly;

--Q: How do casualties vary by severity this year vs last year?

SELECT
  accident_severity,
  EXTRACT(YEAR FROM accident_date) AS year,
  SUM(number_of_casualties) AS casualties
FROM accidents
GROUP BY accident_severity, year
ORDER BY year, accident_severity;

--Q: Which vehicle types caused the most casualties?

SELECT
  vehicle_type,
  SUM(number_of_casualties) AS casualties
FROM accidents
WHERE EXTRACT(YEAR FROM accident_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY vehicle_type
ORDER BY casualties DESC;



--Q: How do monthly casualties compare YoY?

SELECT
  EXTRACT(YEAR FROM accident_date) AS year,
  EXTRACT(MONTH FROM accident_date) AS month,
  SUM(number_of_casualties) AS casualties
FROM accidents
GROUP BY year, month
ORDER BY year, month;


--Q: Which road types had the most casualties?

SELECT
  road_type,
  SUM(number_of_casualties) AS casualties
FROM accidents
WHERE EXTRACT(YEAR FROM accident_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY road_type
ORDER BY casualties DESC;

--Q: Day vs Night casualties by area?

SELECT
  location,
  CASE WHEN EXTRACT(HOUR FROM accident_date) BETWEEN 6 AND 18 THEN 'Day' ELSE 'Night' END AS time_of_day,
  SUM(number_of_casualties) AS casualties
FROM accidents
WHERE EXTRACT(YEAR FROM accident_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY location, time_of_day;



--Q: Which location had the highest accidents?

SELECT
  location,
  SUM(number_of_casualties) AS total_casualties,
  COUNT(*) AS total_accidents
FROM accidents
WHERE EXTRACT(YEAR FROM accident_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY location
ORDER BY total_accidents DESC
LIMIT 1;
