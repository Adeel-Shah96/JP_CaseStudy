-- Calculate Cost per Install (CPI) for adjust and network

SELECT 
  country_code,
  os_name,
  channel,
  campaign,
  creative,
  SUM(cost) as total_cost,
  SUM(installs) as total_installs,
  SUM(network_installs) as total_network_installs,
  AVG(round(coalesce(safe_divide(cost, installs),0),2)) as CPI_adjust,
  AVG(round(coalesce(safe_divide(cost, network_installs),0),2)) as CPI_network
FROM `datataskjp.marketing.ad_spend_installs`
group by 1,2,3,4,5
