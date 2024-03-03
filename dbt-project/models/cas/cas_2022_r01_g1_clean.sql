/*
 Welcome to your first dbt model!
 Did you know that you can also configure models directly within SQL files?
 This will override configurations stated in dbt_project.yml
 
 Try changing "table" to "view" below
 */
{{ config(materialized = 'view')}}
WITH with_period AS (
    SELECT
        PARSE_DATE('%m%Y', monthly_reporting_period) AS reporting_period
        ,CAST(current_loan_delinquency_status AS INT64) as current_loan_delinquency_status
        ,* EXCEPT(current_loan_delinquency_status)
    FROM
        {{ source('cas_loanperf', 'cas_2022_r01_g1')}}
)
SELECT
    reporting_period
    ,current_actual_upb + unscheduled_principal_current AS scheduled_ending_balance
    ,SUM(unscheduled_principal_current) OVER (PARTITION BY loan_identifier ORDER BY reporting_period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS unscheduled_principal_cumulative
    ,SUM(scheduled_principal_current) OVER (PARTITION BY loan_identifier ORDER BY reporting_period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS scheduled_principal_cumulative
    ,SUM(total_principal_current) OVER (PARTITION BY loan_identifier ORDER BY reporting_period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_principal_cumulative
    ,IF(current_loan_delinquency_status >= 2, 1, 0) as dq60plus
    ,IF(current_loan_delinquency_status >= 3, 1, 0) as dq90plus
    ,IF(current_loan_delinquency_status >= 4, 1, 0) as dq120plus
    ,* EXCEPT (reporting_period)
FROM
    with_period
