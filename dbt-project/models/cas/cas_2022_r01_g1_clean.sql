/*
 Welcome to your first dbt model!
 Did you know that you can also configure models directly within SQL files?
 This will override configurations stated in dbt_project.yml
 
 Try changing "table" to "view" below
 */
{{ config(materialized = 'view')}}
WITH datecte AS (
    SELECT
        PARSE_DATE('%m%Y', monthly_reporting_period) AS reporting_period,
        *
    FROM
        {{ source('cas_loanperf', 'cas_2022_r01_g1')}}
)
SELECT
    *
FROM
    datecte
ORDER BY
    datecte.reporting_period
LIMIT
    100
