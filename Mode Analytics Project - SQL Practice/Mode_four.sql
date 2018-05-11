/* 
Four
This query looks at the number of weekly digest emails sent, reengagement emails sent, emails opened and emails clicked through by week
*/
SELECT
  DATE_TRUNC('week', occurred_at) AS week,
  COUNT(CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS "weekly emails",
  COUNT(CASE WHEN action = 'sent_reengagement_email' THEN user_id ELSE NULL END) AS "reengagement emails",
  COUNT(CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS "email opens",
  COUNT(CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS "email clickthroughs"
  FROM tutorial.yammer_emails 
  GROUP BY 1
  ORDER BY 1


