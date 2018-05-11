/*
Two
This query looks at level of engagement by user age in weeks
*/
SELECT
  DATE_TRUNC('week', y.occurred_at) AS week,
  AVG(y.age_at_event) AS "Average age during week",
  COUNT(DISTINCT CASE WHEN y.user_age > 70 THEN y.user_id ELSE NULL END) AS "10+ weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 70 AND y.user_age >= 63 THEN user_id ELSE NULL END) AS "9 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 63 AND y.user_age >= 56 THEN user_id ELSE NULL END) AS "8 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 56 AND y.user_age >= 49 THEN user_id ELSE NULL END) AS "7 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 49 AND y.user_age >= 42 THEN user_id ELSE NULL END) AS "6 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 42 AND y.user_age >= 35 THEN user_id ELSE NULL END) AS "5 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 35 AND y.user_age >= 28 THEN user_id ELSE NULL END) AS "4 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 28 AND y.user_age >= 21 THEN user_id ELSE NULL END) AS "3 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 21 AND y.user_age >= 14 THEN user_id ELSE NULL END) AS "2 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 14 AND y.user_age >= 7 THEN user_id ELSE NULL END) AS "1 weeks",
  COUNT(DISTINCT CASE WHEN y.user_age < 7 THEN y.user_id ELSE NULL END) AS "less than 1 week"

FROM
(SELECT 
  event.occurred_at, -- time the event occurred at
  users.user_id, -- users ID
  DATE_TRUNC('week', users.activated_at) AS activation_week, --Week user was activated
  EXTRACT ('day' FROM (event.occurred_at - users.activated_at)) AS age_at_event, -- age of user when event occurred
  EXTRACT ('day' FROM ('2014-09-01'::TIMESTAMP -users.activated_at)) AS user_age -- user age from sept 1st
  FROM tutorial.yammer_users users
  JOIN tutorial.yammer_events event
  ON users.user_id = event.user_id
  AND event.event_type = 'engagement'
  AND event.event_name = 'login'
  AND event.occurred_at >= '2014-05-01'
  AND event.occurred_at < '2014-09-01'
  WHERE users.activated_at IS NOT NULL
) y
GROUP BY 1
ORDER BY 1
LIMIT 100

