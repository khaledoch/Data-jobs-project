-- Most requested skills from the dashboard's serialized job_skills field.
-- The source stores skills like: ['sql', 'python'].
-- Source table: job_postings_flat

WITH expanded_skills AS (
    SELECT
        TRIM(skill_name) AS skill_name
    FROM job_postings_flat
    CROSS JOIN LATERAL regexp_split_to_table(
        regexp_replace(COALESCE(job_skills, ''), '[\[\]''"]', '', 'g'),
        ','
    ) AS skill_name
)
SELECT
    skill_name,
    COUNT(*) AS job_postings
FROM expanded_skills
WHERE skill_name <> ''
GROUP BY skill_name
ORDER BY job_postings DESC, skill_name
LIMIT 25;
