-- Calculate how CPM changes upon successive impressions watched

--Row number window function would number my impressions for every user and adformat (split by ad format as CPM varies drastically by adformat)

with imp_number as (
SELECT
  userId,
  adUnitFormat,
  platform,
  createdat,
  row_number() over(partition by userId, adUnitFormat order by createdat asc) as impression_number,
  1000*(SUM(amount)/count(*)) as eCPM
FROM `datataskjp.marketing.revenue_cleaned`
group by 1,2,3,4
order by userId
)

select
adUnitFormat,
platform,
impression_number,
avg(eCPM) as avg_cpm
from imp_number
group by 1,2,3
order by 1,2,3
