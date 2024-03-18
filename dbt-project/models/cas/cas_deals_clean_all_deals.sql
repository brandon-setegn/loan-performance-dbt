/*
 This view creates an 'all_deals' deal_name with a set of all records and unions it with existing deals.
 This 'all_deals' allows us to aggregate all deals in the cas_deals_perf model.
 */
{{ config(materialized = 'view')}}

SELECT
    * EXCEPT(deal_name)
    ,'all_deals' as deal_name
FROM 
    {{ ref('cas_deals_clean') }}

UNION ALL

-- Move deal_name to the end of the table so columns are aligned for union
SELECT
    * EXCEPT(deal_name)
    ,deal_name
FROM 
    {{ ref('cas_deals_clean') }}
