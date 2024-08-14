-- To calculate users watching a certain number of impressions

-- Start off with CTE calculating how many impressions each user watched

With user_impressions as (
SELECT
  userId,
  count(*) as impressions,
  1000*(SUM(amount)/count(*)) as eCPM,
FROM `datataskjp.marketing.revenue_cleaned`
group by 1
)

-- Pull in impression count from CTE and count how many users have this impression count
  
select
user_impressions.impressions,
count(*) as count_of_users
from user_impressions
group by 1
order by user_impressions.impressions
