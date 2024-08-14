-- I want to verify if there are Non-LAT users in revenue table

select
os_name,
limitAdTracking
from `datataskjp.marketing.Installs` ins join `datataskjp.marketing.revenue_cleaned` rc on ins.userId = rc.userId
where os_name = 'ios' and cast(limitAdTracking as string) = 'false'
