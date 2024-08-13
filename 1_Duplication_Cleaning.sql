-- In order to remove duplications from tables in BigQuery

-- For Installs table

CREATE OR REPLACE TABLE `datataskjp.marketing.Installs`
AS
SELECT DISTINCT * FROM `datataskjp.marketing.Installs`

-- For Ad Spend table  
CREATE OR REPLACE TABLE `datataskjp.marketing.ad_spend_installs`
AS
SELECT DISTINCT * FROM `datataskjp.marketing.ad_spend_installs`

-- For revenue table  
CREATE OR REPLACE TABLE `datataskjp.marketing.revenue`
AS
SELECT DISTINCT * FROM `datataskjp.marketing.revenue`

-- Checking data
SELECT * FROM `datataskjp.marketing.revenue`
