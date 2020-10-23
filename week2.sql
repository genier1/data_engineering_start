SELECT to_char(ts, 'YYYY-MM') AS month, count(DISTINCT sc.userid) AS total
FROM raw_data.user_session_channel AS sc 
LEFT JOIN raw_data.session_timestamp AS st ON sc.sessionid = st.sessionid
GROUP BY 1 
ORDER BY 1 