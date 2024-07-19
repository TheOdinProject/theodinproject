SELECT
  ROW_NUMBER() OVER (ORDER BY created_at::DATE ASC) as id,
  created_at::DATE as date,
  COUNT(*) AS sign_ups_count
FROM users
  GROUP BY created_at::DATE
  ORDER BY created_at::DATE ASC
