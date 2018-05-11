/*
Three
This query looks at weekly engagement by advice type
*/
SELECT 
  DATE_TRUNC('week', occurred_at) AS week,
  COUNT(DISTINCT user_id) AS "weekly active users",
  COUNT(DISTINCT CASE WHEN device IN ('lenovo thinkpad', 'mac mini', 'macbook air','dell inspiron notebook', 'macbook pro', 'acer aspire desktop',
          'asus chromebook', 'acer aspire notebook', 'dell inspiron desktop', 'hp pavilion desktop')  THEN user_id ELSE NULL END) AS computer, -- Counts distinct computer users grouped by week 
  COUNT(DISTINCT CASE WHEN device IN ('amazon fire phone', 'samsung galaxy note', 'samsung galaxy s4','nexus 5','iphone 5s', 'iphone 5', 'iphone 4s', 
       'htc one', 'nokia lumia 635') THEN user_id ELSE NULL END) AS phone, -- Counts distinct phone users grouped by week
  COUNT(DISTINCT CASE WHEN device IN ('windows surface', 'nexus 7', 'nexus 10', 'ipad mini','kindle fire', 'ipad air',
        'samsumg galaxy tablet') THEN user_id ELSE NULL END) AS tablet -- Counts distinct tablet users grouped by week
  FROM tutorial.yammer_events
  WHERE event_type = 'engagement'
  AND event_name = 'login'
  GROUP BY 1
  ORDER BY 1
  LIMIT 100

