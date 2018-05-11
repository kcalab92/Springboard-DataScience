/*
One:
This query looks at daily signup growth by all users and by activated users
*/

SELECT 
  DATE_TRUNC('day', created_at) as day, -- Truncates created at data by day
  COUNT(created_at) as all_users_count, 
  COUNT(CASE WHEN activated_at IS NOT NULL THEN user_id ELSE NULL END) AS activated_users_count
  FROM tutorial.yammer_users 
   WHERE created_at >= '2014-06-01'
   AND created_at < '2014-09-01'
  GROUP BY 1
  ORDER BY 1


