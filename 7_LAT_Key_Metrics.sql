-- Understanding the impact of LAT users vs Non-LAT users

-- Start off with CTEs for calculating DAU & eDAU

WITH edau_platform AS (
  SELECT
  platform,
  count(distinct(userId)) as eDAU
  from `datataskjp.marketing.revenue_cleaned`
  where platform is not null
  group by 1
),

dau_platform AS (
  SELECT
  os_name as platform,
  count(distinct(userId)) as DAU
  from `datataskjp.marketing.Installs`
  where os_name is not null
  group by 1
)

SELECT
  network,
  rc.platform,
  limitAdTracking,
  edp.eDAU,
  dp.DAU,
  sum(amount) as total_revenue,
  count(*) as impressions,
  1000*(SUM(amount)/count(*)) as eCPM,
  sum(amount) / dp.DAU as ARPDAU,
  sum(amount) / edp.eDAU as ARPeDAU,
  count(*) / dp.DAU as Imps_per_DAU,
  count(*) / edp.eDAU as Imps_per_eDAU
FROM `datataskjp.marketing.revenue_cleaned` rc
join `datataskjp.marketing.Installs` ins on rc.userId = ins.userId
join edau_platform edp on rc.platform = edp.platform
join dau_platform dp on rc.platform = dp.platform
group by 1,2,3,4,5
order by network
