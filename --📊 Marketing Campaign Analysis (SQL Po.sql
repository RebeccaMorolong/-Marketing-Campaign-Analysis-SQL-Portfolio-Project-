--📊 Marketing Campaign Analysis (SQL Portfolio Project)
--🔧 Project Overview
--Analyze customer responses to marketing campaigns to assess performance, segment audiences, and optimize future strategies.


SELECT * FROM campaign_interactions

--1. Overall Campaign Response Rate

SELECT 
  campaign_id,
  COUNT(*) AS total_sent,
  SUM(CASE WHEN response = 1 THEN 1 ELSE 0 END) AS total_responses,
  ROUND(SUM(CASE WHEN response = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS response_rate_pct
FROM campaign_interactions
GROUP BY campaign_id;

--2. Top Performing Channels by ROI

SELECT 
  c.channel,
  COUNT(ci.interaction_id) AS total_interactions,
  SUM(ci.revenue_generated) AS total_revenue,
  ROUND(SUM(ci.revenue_generated) / COUNT(ci.interaction_id), 2) AS avg_revenue_per_interaction
FROM campaigns c
JOIN campaign_interactions ci ON c.campaign_id = ci.campaign_id
GROUP BY c.channel
ORDER BY avg_revenue_per_interaction DESC;

--3. Customer Segmentation by Response Behavior

SELECT 
  cust.education,
  cust.marital_status,
  COUNT(DISTINCT ci.customer_id) AS total_customers,
  SUM(ci.response) AS total_responses,
  ROUND(SUM(ci.response) * 100.0 / COUNT(ci.customer_id), 2) AS response_rate
FROM customers cust
JOIN campaign_interactions ci ON cust.customer_id = ci.customer_id
GROUP BY cust.education, cust.marital_status
ORDER BY response_rate DESC;

