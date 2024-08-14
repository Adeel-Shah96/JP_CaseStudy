-- CTR is the conversion between impressions and clicks
-- Install rate is the conversion between clicks and installs

SELECT 
  country_code,
  os_name,
  channel,
  campaign,
  creative,
  SUM(cost) as total_cost,
  SUM(installs) as total_installs,
  SUM(network_installs) as total_network_installs,
  AVG(100*round(coalesce(safe_divide(network_clicks,network_impressions),0),2)) as CTR,
  AVG(100*round(coalesce(safe_divide(installs, network_clicks),0),2)) as install_rate_adjust,
  AVG(100*round(coalesce(safe_divide(network_installs, network_clicks),0),2)) as install_rate_network,
  AVG(round(coalesce(safe_divide(cost, installs),0),2)) as CPI_adjust,
  AVG(round(coalesce(safe_divide(cost, network_installs),0),2)) as CPI_network
FROM `datataskjp.marketing.ad_spend_installs`
group by 1,2,3,4,5
