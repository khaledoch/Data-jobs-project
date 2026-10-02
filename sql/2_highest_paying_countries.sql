-- Countries with the highest reported yearly salaries.
-- Requires at least 10 postings with a yearly salary to reduce small-sample noise.
-- Source table: job_postings_flat

SELECT
    job_country,
    COUNT(*) AS postings_with_yearly_salary,
    ROUND(
        (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg))::numeric,
        2
    ) AS median_yearly_salary,
    ROUND(AVG(salary_year_avg), 2) AS average_yearly_salary,
    ROUND(MIN(salary_year_avg), 2) AS lowest_reported_salary,
    ROUND(MAX(salary_year_avg), 2) AS highest_reported_salary
FROM job_postings_flat
WHERE job_country IS NOT NULL
  AND salary_year_avg IS NOT NULL
GROUP BY job_country
HAVING COUNT(*) >= 10
ORDER BY median_yearly_salary DESC, postings_with_yearly_salary DESC;
