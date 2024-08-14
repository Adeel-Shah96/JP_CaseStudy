--Recreating tables to ensure correct column data types and no null timestamps

CREATE OR REPLACE TABLE `datataskjp.marketing.revenue_cleaned` AS
SELECT 
  userId,
  CAST(createdat as timestamp) as createdat,
  countryCode,
  platform,
  -- null amounts default to 0
  CAST(COALESCE(amount, 0) as float64) as amount,
  eventId,
  source,
  network,
  adUnitFormat,
  deviceId,
  advertisingId,
  packageName,
  adUnitName
FROM 
  datataskjp.marketing.revenue
WHERE 
  -- createdat cast can be null (avoiding errors) and then filter for not null
  createdat IS NOT NULL 
  AND SAFE_CAST(createdat AS TIMESTAMP) IS NOT NULL
  -- amount is positive
  AND amount >= 0
