/*
Five
This query looks at the weekly open rate and click through rate for both retained readers and all readers
*/
SELECT week,
       "weekly opens"/CASE WHEN "weekly emails" = 0 THEN 1 ELSE "weekly emails" END::FLOAT AS "weekly open rate",
       "weekly clickthrough rate"/CASE WHEN "weekly opens" = 0 THEN 1 ELSE "weekly opens" END::FLOAT AS "weekly click through rate",
       "retain opens"/CASE WHEN "retain emails" = 0 THEN 1 ELSE "retain emails" END::FLOAT AS "retain open rate",
       "retain clickthrough rate"/CASE WHEN "retain opens" = 0 THEN 1 ELSE "retain opens" END::FLOAT AS "retain clickthrough"
  FROM (
SELECT DATE_TRUNC('week',email1.occurred_at) AS week,
       COUNT(CASE WHEN email1.action = 'sent_weekly_digest' THEN email1.user_id ELSE NULL END) AS "weekly emails",
       COUNT(CASE WHEN email1.action = 'sent_weekly_digest' THEN email2.user_id ELSE NULL END) AS "weekly opens",
       COUNT(CASE WHEN email1.action = 'sent_weekly_digest' THEN email3.user_id ELSE NULL END) AS "weekly clickthrough rate",
       COUNT(CASE WHEN email1.action = 'sent_reengagement_email' THEN email1.user_id ELSE NULL END) AS "retain emails",
       COUNT(CASE WHEN email1.action = 'sent_reengagement_email' THEN email2.user_id ELSE NULL END) AS "retain opens",
       COUNT(CASE WHEN email1.action = 'sent_reengagement_email' THEN email3.user_id ELSE NULL END) AS "retain clickthrough rate"
  FROM tutorial.yammer_emails email1
  LEFT JOIN tutorial.yammer_emails email2
    ON email2.occurred_at >= email1.occurred_at
   AND email2.occurred_at < email1.occurred_at + INTERVAL '5 MINUTE'
   AND email2.user_id = email1.user_id
   AND email2.action = 'email_open'
  LEFT JOIN tutorial.yammer_emails email3
    ON email3.occurred_at >= email2.occurred_at
   AND email3.occurred_at < email2.occurred_at + INTERVAL '5 MINUTE'
   AND email3.user_id = email2.user_id
   AND email3.action = 'email_clickthrough'
 WHERE email1.occurred_at >= '2014-06-01'
   AND email1.occurred_at < '2014-09-01'
   AND email1.action IN ('sent_weekly_digest','sent_reengagement_email')
 GROUP BY 1
       ) x
 ORDER BY 1
