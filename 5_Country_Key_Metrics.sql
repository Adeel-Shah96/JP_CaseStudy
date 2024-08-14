-- Start with DAU and eDAU CTEs

WITH edau_platform AS (
  SELECT
  platform,
  countryCode,
  count(distinct(userId)) as eDAU
  from `datataskjp.marketing.revenue_cleaned`
  where platform is not null
  group by 1,2
),

dau_platform AS (
  SELECT
  os_name as platform,
  countryCode,
  count(distinct(userId)) as DAU
  from `datataskjp.marketing.Installs`
  where os_name is not null
  group by 1,2
)

SELECT
  rc.countrycode,
  rc.platform,
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
join edau_platform edp on rc.platform = edp.platform and rc.countryCode = edp.countryCode
join dau_platform dp on rc.platform = dp.platform and rc.countryCode = dp.countryCode
group by 1,2,3,4
order by 1,2
