/*
 Welcome to your first dbt model!
 Did you know that you can also configure models directly within SQL files?
 This will override configurations stated in dbt_project.yml
 
 Try changing "table" to "view" below
 */
{{ config(materialized = 'table')}}
SELECT
  reporting_period,
  SUM(unscheduled_principal_current) / SUM(scheduled_ending_balance) AS smm,
  (1 - POW(
    (1 - (SUM(unscheduled_principal_current) / SUM(scheduled_ending_balance)))
    ,12
  )) * 100 as cpr,
  SUM(scheduled_ending_balance) as scheduled_ending_balance,
  SUM(unscheduled_principal_cumulative) as unscheduled_principal_cumulative,
  SUM(scheduled_principal_cumulative) as scheduled_principal_cumulative,
  SUM(total_principal_cumulative) as total_principal_cumulative,
  countif(scheduled_ending_balance > 0) as active_loan_count,
  count(*) as total_loan_count,
  sum(total_deferral_amount) as total_deferral_amount,
  sum(interest_bearing_upb) as interest_bearing_upb,
  sum(principal_forgiveness_amount) as principal_forgiveness_amount,
  sum(modification_related_non_interest_bearing_upb) as modification_related_non_interest_bearing_upb,
  sum(current_period_modification_loss_amount) as current_period_modification_loss_amount,
  sum(delinquent_accrued_interest) as delinquent_accrued_interest
FROM
    {{ ref("cas_2022_r01_g1_clean")}}
GROUP BY
  reporting_period
