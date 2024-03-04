/*
 Welcome to your first dbt model!
 Did you know that you can also configure models directly within SQL files?
 This will override configurations stated in dbt_project.yml
 
 Try changing "table" to "view" below
 */
{{ config(materialized = 'view')}}

SELECT
    * EXCEPT(deal_name)
    ,'all_deals' as deal_name
FROM 
    {{ ref('cas_deals_clean') }}

UNION ALL

-- Move deal_name to the end of the table
SELECT
    * EXCEPT(deal_name)
    ,deal_name
FROM 
    {{ ref('cas_deals_clean') }}
