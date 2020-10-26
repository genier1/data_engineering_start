CREATE TABLE lcj1683.monthly_channel_revenue AS
SELECT to_char(st.ts, 'YYYY-MM') AS month, sc.channel, COUNT(DISTINCT userid) AS uniqueUsers, 
COUNT(DISTINCT CASE WHEN amount IS NOT NULL THEN userid END) AS paidUsers,  
concat(round(COUNT(DISTINCT CASE WHEN amount IS NOT NULL THEN userid END) / (COUNT(DISTINCT userid)::numeric) * 100, 1), '%') AS conversionRate , 
sum(amount) AS grossRevenue,
sum(amount) - COALESCE(SUM(CASE WHEN refunded = true THEN amount END), 0) AS netRevenue 
FROM raw_data.user_session_channel AS sc
LEFT JOIN raw_data.session_timestamp AS st 
ON sc.sessionid = st.sessionid
LEFT JOIN raw_data.session_transaction AS t 
ON sc.sessionid = t.sessionid 
LEFT JOIN raw_data.channel AS c 
ON sc.channel = c.channelname
GROUP BY 1, 2 
ORDER BY 1 
