-- Pre-operation: delete recent data for incremental update
-- This comment has been generalized to reflect a common data pipeline task.
-- DELETE FROM data_warehouse.your_anonymized_table_name
-- WHERE date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE();

WITH content_metrics AS (
  SELECT
    event_date AS date,
    REGEXP_REPLACE(net.host(c.URL), r'www\.', '') AS site_domain,
    a1.parent_brand AS parent_brand,
    COUNT(DISTINCT user_identifier) AS users,
    COUNT(DISTINCT CASE WHEN user_segment = 'Non-Subscriber' THEN user_identifier END) AS free_tier_users,
    COUNT(DISTINCT CASE WHEN user_segment = 'Premium Subscriber' THEN user_identifier END) AS premium_users,
    COUNT(DISTINCT session_id) AS unique_pageviews,
    COUNT(session_id) AS pageviews,
    SUM(interaction_clicks) AS call_to_action_clicks,
    SUM(engagement_duration) AS total_engagement_time
  FROM `project.dataset.content_analytics_prod` AS a
  LEFT JOIN `project.dataset.brand_mapping` a1
    ON LOWER(IFNULL(FORMAT(net.reg_domain(site)), site)) = LOWER(a1.Brand)
  LEFT JOIN `project.dataset.parent_brand_list` c
    ON a1.parent_brand = c.parent_brand
  WHERE event_date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE()
  GROUP BY date, site_domain, parent_brand
),

commerce_metrics AS (
  SELECT
    transaction_date,
    REGEXP_REPLACE(net.host(c.URL), r'www\.', '') AS transaction_website,
    a1.Parent_Brand AS parent_brand,
    SUM(commerce_revenue_usd) AS commerce_revenue_usd,
    SUM(commerce_revenue_gbp) AS commerce_revenue_gbp,
    SUM(commerce_sales_order_value_usd) AS commerce_sales_order_value_usd,
    SUM(commerce_sales_order_value_gbp) AS commerce_sales_order_value_gbp,
    SUM(commerce_transactions) AS commerce_transactions
  FROM `project.dataset.commerce_data_base` AS a
  LEFT JOIN `project.dataset.brand_mapping` a1
    ON LOWER(IFNULL(FORMAT(net.reg_domain(transaction_website)), transaction_website)) = LOWER(a1.Brand)
  LEFT JOIN `project.dataset.parent_brand_list` c
    ON a1.parent_brand = c.parent_brand
  WHERE transaction_date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE()
    AND off_platform_source = "External Partner" -- Replaced specific name with generic
  GROUP BY transaction_date, transaction_website, parent_brand
),

ad_metrics AS (
  SELECT
    date,
    REGEXP_REPLACE(net.host(c.URL), r'www\.', '') AS domain,
    a1.parent_brand AS parent_brand,
    SUM(impressions) AS ads_impressions,
    SUM(revenue) AS ads_revenue_usd_daily,
    SUM(revenue_GBP_daily) AS ads_revenue_gbp_daily,
    SUM(revenue_GBP_monthly) AS ads_revenue_gbp_monthly
  FROM `project.dataset.ads_metrics` a
  LEFT JOIN `project.dataset.brand_mapping` a1
    ON LOWER(IFNULL(FORMAT(net.reg_domain(site)), site)) = LOWER(a1.Brand)
  LEFT JOIN `project.dataset.parent_brand_list` c
    ON a1.parent_brand = c.parent_brand
  WHERE date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE()
    AND LOWER(source) LIKE '%external partner%' -- Replaced specific name with generic
  GROUP BY date, domain, parent_brand
)

SELECT
  -- Compose a hash key combining date, domain, and brand for a unique, anonymized row identifier
  SHA256(
    ARRAY_TO_STRING(
      [
        COALESCE(CAST(a.date AS STRING), CAST(b.transaction_date AS STRING), CAST(c.date AS STRING), 'unknown'),
        COALESCE(a.site_domain, b.transaction_website, c.domain, 'unknown'),
        COALESCE(a.parent_brand, b.parent_brand, c.parent_brand, 'unknown')
      ],
      "_"
    )
  ) AS hash_key,
  COALESCE(a.date, b.transaction_date, c.date) AS date,
  COALESCE(a.site_domain, b.transaction_website, c.domain) AS site_domain,
  COALESCE(a.parent_brand, b.parent_brand, c.parent_brand) AS parent_brand,
  a.users,
  a.free_tier_users,
  a.premium_users,
  a.unique_pageviews,
  a.pageviews,
  a.call_to_action_clicks,
  a.total_engagement_time,
  b.commerce_revenue_usd,
  b.commerce_revenue_gbp,
  b.commerce_sales_order_value_usd,
  b.commerce_sales_order_value_gbp,
  b.commerce_transactions,
  c.ads_impressions,
  c.ads_revenue_gbp_daily,
  c.ads_revenue_gbp_monthly,
  c.ads_revenue_usd_daily
FROM content_metrics a
FULL JOIN commerce_metrics b
  ON a.date = b.transaction_date
  AND LOWER(a.parent_brand) = LOWER(b.parent_brand)
FULL JOIN ad_metrics c
  ON a.date = c.date
  AND LOWER(a.parent_brand) = LOWER(c.parent_brand);
