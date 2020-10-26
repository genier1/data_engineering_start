SELECT sc.userid, sum(amount) AS total_amount
FROM raw_data.session_transaction AS st 
LEFT JOIN raw_data.user_session_channel AS sc 
ON st.sessionid = sc.sessionid
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 10 