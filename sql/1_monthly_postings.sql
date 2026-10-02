-- Monthly job-posting volume and work arrangement mix.
-- Source table: job_postings_flat

SELECT
    DATE_TRUNC('month', job_posted_date)::date AS posting_month,
    COUNT(*) AS total_postings,
    COUNT(*) FILTER (WHERE job_work_from_home IS TRUE) AS remote_postings,
    COUNT(*) FILTER (WHERE job_work_from_home IS FALSE) AS non_remote_postings,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE job_work_from_home IS TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS remote_share_percent
FROM job_postings_flat
WHERE job_posted_date IS NOT NULL
GROUP BY posting_month
ORDER BY posting_month;
