-- First part of the query gets us the intersections between installs table and ad spend table

SELECT 
    ads.country_code,
    ads.os_name,
    ads.channel,
    ads.campaign,
    ads.creative,
    COUNT(ins.userId) AS installs_count,
    COUNT(ads.cost) AS ad_spend_count
FROM 
    `datataskjp.marketing.ad_spend_installs` AS ads
LEFT JOIN 
    `datataskjp.marketing.Installs` AS ins 
ON 
    ads.country_code = ins.countryCode
    AND ads.os_name = ins.os_name
    AND ads.channel = ins.channel
    AND ads.campaign = ins.campaign
    AND ads.creative = ins.creative
GROUP BY 
    ads.country_code, 
    ads.os_name, 
    ads.channel, 
    ads.campaign, 
    ads.creative
HAVING 
    installs_count > 0 AND ad_spend_count > 0;


-- Above query returned one userID, so to check if this UserID exists in the revenue table:

select
*
from `datataskjp.marketing.revenue_cleaned`
where userId = '32713348L5f9a484f4f32bcdc7e3bbd7bd62d'
