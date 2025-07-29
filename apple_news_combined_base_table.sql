
-- Pre-operation: delete recent data for incremental update
-- DELETE FROM audience_core.your_table_name
-- WHERE date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE();

WITH apple AS (
  SELECT 
    date,
    REGEXP_REPLACE(net.host(c.URL), r'www\.', '') AS site_domain,
    a1.parent_brand AS parent_brand,
    COUNT(DISTINCT userid) AS users,
    COUNT(DISTINCT CASE WHEN subscribertype = 'Non-Subscriber' THEN userid END) AS nonsubscribed_users,
    COUNT(DISTINCT CASE WHEN subscribertype = 'Apple News+ Subscriber' THEN userid END) AS subscribed_users,
    COUNT(DISTINCT viewId) AS unique_pageviews,
    COUNT(viewId) AS pageviews,
    SUM(affiliateClicks) AS affiliate_clicks,
    SUM(engagedtime) AS total_engaged_time
  FROM `project.dataset.apple_news_prod` AS a
  LEFT JOIN `project.dataset.master_brand_brand_map` a1
    ON LOWER(IFNULL(FORMAT(net.reg_domain(site)), site)) = LOWER(a1.Brand)
  LEFT JOIN `project.dataset.master_brand_parent_list` c
    ON a1.parent_brand = c.parent_brand
  WHERE date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE()
  GROUP BY date, site_domain, parent_brand
),

ecom AS (
  SELECT
    transaction_date,
    REGEXP_REPLACE(net.host(c.URL), r'www\.', '') AS transaction_website,
    a1.Parent_Brand AS parent_brand,
    SUM(ecommerce_revenue_usd_constant_budget_adj) AS ecommerce_revenue_usd_constant_budget_adj,
    SUM(ecommerce_revenue_gbp_constant_budget_adj) AS ecommerce_revenue_gbp_constant_budget_adj,
    SUM(ecommerce_sales_order_value_usd_constant_budget_adj) AS ecommerce_sales_order_value_usd_constant_budget_adj,
    SUM(ecommerce_sales_order_value_gbp_constant_budget_adj) AS ecommerce_sales_order_value_gbp_constant_budget_adj,
    SUM(ecommerce_transactions_adj) AS ecommerce_transactions_adj
  FROM `project.dataset.ecommerce_revenue_base` AS a
  LEFT JOIN `project.dataset.master_brand_brand_map` a1
    ON LOWER(IFNULL(FORMAT(net.reg_domain(transaction_website)), transaction_website)) = LOWER(a1.Brand)
  LEFT JOIN `project.dataset.master_brand_parent_list` c
    ON a1.parent_brand = c.parent_brand
  WHERE transaction_date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE()
    AND off_platform_source = "Apple News"
  GROUP BY transaction_date, transaction_website, parent_brand
),

ads AS (
  SELECT
    date,
    REGEXP_REPLACE(net.host(c.URL), r'www\.', '') AS domain,
    a1.parent_brand AS parent_brand,
    SUM(impressions) AS ads_impressions,
    SUM(revenue) AS ads_revenue_usd_daily,
    SUM(revenue_GBP_daily) AS ads_revenue_gbp_daily,
    SUM(revenue_GBP_monthly) AS ads_revenue_gbp_monthly
  FROM `project.dataset.unified_ads` a
  LEFT JOIN `project.dataset.master_brand_brand_map` a1
    ON LOWER(IFNULL(FORMAT(net.reg_domain(site)), site)) = LOWER(a1.Brand)
  LEFT JOIN `project.dataset.master_brand_parent_list` c
    ON a1.parent_brand = c.parent_brand
  WHERE date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND CURRENT_DATE()
    AND LOWER(source) LIKE '%apple news%'
  GROUP BY date, domain, parent_brand
)

SELECT
  -- Compose a hash key combining date, domain, and brand
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
  a.nonsubscribed_users,
  a.subscribed_users,
  a.unique_pageviews,
  a.pageviews,
  a.affiliate_clicks,
  a.total_engaged_time,
  b.ecommerce_revenue_usd_constant_budget_adj,
  b.ecommerce_revenue_gbp_constant_budget_adj,
  b.ecommerce_sales_order_value_usd_constant_budget_adj,
  b.ecommerce_sales_order_value_gbp_constant_budget_adj,
  b.ecommerce_transactions_adj,
  c.ads_impressions,
  c.ads_revenue_gbp_daily,
  c.ads_revenue_gbp_monthly,
  c.ads_revenue_usd_daily
FROM apple a
FULL JOIN ecom b
  ON a.date = b.transaction_date
  AND LOWER(a.parent_brand) = LOWER(b.parent_brand)
FULL JOIN ads c
  ON a.date = c.date
  AND LOWER(a.parent_brand) = LOWER(c.parent_brand);
