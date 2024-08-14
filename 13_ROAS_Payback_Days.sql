-- ROAS calculate how much of our revenue is obtained by first day
-- payback_days calculates how long it will take to payback cost of campaign/creative

SELECT 
  ads.country_code,
  ads.os_name,
  ads.channel,
  ads.campaign,
  ads.creative,
  ROUND(100*coalesce(safe_divide(SUM(amount),SUM(cost)),0),1) as ROAS,
  CEIL(safe_divide(1,safe_divide(SUM(amount),SUM(cost)))) as payback_days
FROM `datataskjp.marketing.ad_spend_installs` as ads 
join `datataskjp.marketing.Installs` as ins on ads.country_code = ins.countryCode
and ads.os_name = ins.os_name and ads.channel = ins.channel and ads.campaign = ins.campaign and ads.creative = ins.creative
join `datataskjp.marketing.revenue_cleaned` as rc on ins.userId = rc.userId
group by 1,2,3,4,5
