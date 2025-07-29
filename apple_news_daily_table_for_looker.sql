/*
Dataform Configuration:

config {
  type: "incremental",
  schema: "audience_core",
  tags:["apple-news","sunday-6pm-full-refresh"],
  protected: false,
  uniqueKey: ["hash_key"],
  assertions: {
    nonNull: [ "parent_brand"]
  },
  bigquery: {
    partitionBy: "date",
    updatePartitionFilter: "date>= DATE_SUB(current_date(), INTERVAL 90 DAY)",
    clusterBy: ["parent_brand","site_domain"],
    labels: {
      "managed-by": "dataform"
    }
  },
  description: "Daily aggregations and comparisons of Apple News Stats combined with ecom and ads data",
  columns: {
    "hash_key":"combination of date , brand and sitedomain",
    "date": "day, format YYYY-MM-DD",
    "site_domain":"Clean site without 'www' or '/'",
    "parent_brand":"joined via the master_brand_brand_map",
    "users":"count of distinct userids",
    "nonsubscribed_users":"count of distinct userids where subscribertype = 'Non-Subscriber'",
    "subscribed_users":"count of distinct userids where subscribertype = 'Apple News+ Subscriber'",
    "unique_pageviews":"count of distinct de-duped viewids where eventtype = ARTICLE_VIEW_EVENT",
    "pageviews":"added in to test the unique_pageviews",
    "total_engaged_time":"total number of seconds during which the user was engaged with the article",
    "affiliate_clicks":"total number of clicks to affiliates, calculated as a count of 'ShoppingLinkTapEvents'.",
    "ecommerce_revenue_usd_constant_budget_adj":"Affiliate commission converted to USD based on the changing budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base",
    "ecommerce_revenue_gbp_constant_budget_adj":"Affiliate commission converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base",
    "ecommerce_sales_order_value_usd_constant_budget_adj":"Sales order value converted to USD based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base",
    "ecommerce_sales_order_value_gbp_constant_budget_adj":"Sales order value converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base",
    "ecommerce_transactions_adj":"Site level count of the number of transactions, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base",
    "ads_impressions":"Sum off impressions from unified_ads",
    "ads_revenue_usd_daily":"Sum of revenue from unified_ads",
    "ads_revenue_gbp_daily":"Sum of revenue converted into GBP. Using Netsuite exchange rates from unified_ads",
    "ads_revenue_gbp_monthly":"Same as above using exchange rate of the last day of the month from unified_ads",
    "users_1_week_ago":"count of distinct userids, same day 1 weeks ago.",
    "nonsubscribed_users_1_week_ago":"count of distinct userids where subscribertype = 'Non-Subscriber', same day 1 weeks ago.",
    "subscribed_users_1_week_ago":"count of distinct userids where subscribertype = 'Apple News+ Subscriber', same day 1 weeks ago.",
    "unique_pageviews_1_week_ago":"count of distinct de-duped viewids where eventtype = ARTICLE_VIEW_EVENT, same day 1 weeks ago.",
    "pageviews_1_week_ago":"added in to test the unique_pageviews, same day 1 weeks ago.",
    "total_engaged_time_1_week_ago":"total number of seconds during which the user was engaged with the article, same day 1 weeks ago.",
    "affiliate_clicks_1_week_ago":"total number of clicks to affiliates, calculated as a count of 'ShoppingLinkTapEvents', same day 1 weeks ago.",
    "ecommerce_revenue_usd_constant_budget_adj_1_week_ago":"Affiliate commission converted to USD based on the changing budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 1 weeks ago.",
    "ecommerce_revenue_gbp_constant_budget_adj_1_week_ago":"Affiliate commission converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 1 weeks ago.",
    "ecommerce_sales_order_value_usd_constant_budget_adj_1_week_ago":"Sales order value converted to USD based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 1 weeks ago.",
    "ecommerce_sales_order_value_gbp_constant_budget_adj_1_week_ago":"Sales order value converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 1 weeks ago.",
    "ecommerce_transactions_adj_1_week_ago":"Site level count of the number of transactions, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base",
    "ads_impressions_1_week_ago":"Sum off impressions from unified_ads 1 weeks ago.",
    "ads_revenue_usd_daily_1_week_ago":"Sum of revenue from unified_ads 1 weeks ago.",
    "ads_revenue_gbp_daily_1_week_ago":"Sum of revenue converted into GBP. Using Netsuite exchange rates from unified_ads 1 weeks ago.",
    "ads_revenue_gbp_monthly_1_week_ago":"Same as above using exchange rate of the last day of the month from unified_ads 1 weeks ago.",
    "users_2_week_ago":"count of distinct userids, same day 2 weeks ago.",
    "nonsubscribed_users_2_week_ago":"count of distinct userids where subscribertype = 'Non-Subscriber', same day 2 weeks ago.",
    "subscribed_users_2_week_ago":"count of distinct userids where subscribertype = 'Apple News+ Subscriber', same day 2 weeks ago.",
    "unique_pageviews_2_week_ago":"count of distinct de-duped viewids where eventtype = ARTICLE_VIEW_EVENT, same day 2 weeks ago.",
    "pageviews_2_week_ago":"added in to test the unique_pageviews, same day 2 weeks ago.",
    "total_engaged_time_2_week_ago":"total number of seconds during which the user was engaged with the article, same day 2 weeks ago.",
    "affiliate_clicks_2_week_ago":"total number of clicks to affiliates, calculated as a count of 'ShoppingLinkTapEvents', same day 2 weeks ago.",
    "ecommerce_revenue_usd_constant_budget_adj_2_week_ago":"Affiliate commission converted to USD based on the changing budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 2 weeks ago.",
    "ecommerce_revenue_gbp_constant_budget_adj_2_week_ago":"Affiliate commission converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 2 weeks ago.",
    "ecommerce_sales_order_value_usd_constant_budget_adj_2_week_ago":"Sales order value converted to USD based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 2 weeks ago.",
    "ecommerce_sales_order_value_gbp_constant_budget_adj_2_week_ago":"Sales order value converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 2 weeks ago.",
    "ecommerce_transactions_adj_2_week_ago":"Site level count of the number of transactions, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base  same day 2 weeks ago.",
    "ads_impressions_2_week_ago":"Sum off impressions from unified_ads 2 weeks ago.",
    "ads_revenue_usd_daily_2_week_ago":"Sum of revenue from unified_ads 2 weeks ago.",
    "ads_revenue_gbp_daily_2_week_ago":"Sum of revenue converted into GBP. Using Netsuite exchange rates from unified_ads 2 weeks ago.",
    "ads_revenue_gbp_monthly_2_week_ago":"Same as above using exchange rate of the last day of the month from unified_ads 2 weeks ago.",
    "users_4_week_ago":"count of distinct userids, same day 4 weeks ago.",
    "nonsubscribed_users_4_week_ago":"count of distinct userids where subscribertype = 'Non-Subscriber', same day 4 weeks ago.",
    "subscribed_users_4_week_ago":"count of distinct userids where subscribertype = 'Apple News+ Subscriber', same day 4 weeks ago.",
    "unique_pageviews_4_week_ago":"count of distinct de-duped viewids where eventtype = ARTICLE_VIEW_EVENT, same day 4 weeks ago.",
    "pageviews_4_week_ago":"added in to test the unique_pageviews, same day 4 weeks ago.",
    "total_engaged_time_4_week_ago":"total number of seconds during which the user was engaged with the article, same day 4 weeks ago.",
    "affiliate_clicks_4_week_ago":"total number of clicks to affiliates, calculated as a count of 'ShoppingLinkTapEvents', same day 4 weeks ago.",
    "ecommerce_revenue_usd_constant_budget_adj_4_week_ago":"Affiliate commission converted to USD based on the changing budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 4 weeks ago.",
    "ecommerce_revenue_gbp_constant_budget_adj_4_week_ago":"Affiliate commission converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 4 weeks ago.",
    "ecommerce_sales_order_value_usd_constant_budget_adj_4_week_ago":"Sales order value converted to USD based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 4 weeks ago.",
    "ecommerce_sales_order_value_gbp_constant_budget_adj_4_week_ago":"Sales order value converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 4 weeks ago.",
    "ecommerce_transactions_adj_4_week_ago":"Site level count of the number of transactions, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base  same day 4 weeks ago.",
    "ads_impressions_4_week_ago":"Sum off impressions from unified_ads 4 weeks ago.",
    "ads_revenue_usd_daily_4_week_ago":"Sum of revenue from unified_ads 4 weeks ago.",
    "ads_revenue_gbp_daily_4_week_ago":"Sum of revenue converted into GBP. Using Netsuite exchange rates from unified_ads 4 weeks ago.",
    "ads_revenue_gbp_monthly_4_week_ago":"Same as above using exchange rate of the last day of the month from unified_ads 4 weeks ago.",
    "users_52_week_ago":"count of distinct userids, same day 52 weeks ago.",
    "nonsubscribed_users_52_week_ago":"count of distinct userids where subscribertype = 'Non-Subscriber',same day 52 weeks ago.",
    "subscribed_users_52_week_ago":"count of distinct userids where subscribertype = 'Apple News+ Subscriber',same day 52 weeks ago.",
    "unique_pageviews_52_week_ago":"count of distinct de-duped viewids where eventtype = ARTICLE_VIEW_EVENT, same day 52 weeks ago.",
    "pageviews_52_week_ago":"added in to test the unique_pageviews ,same day 52 weeks ago.",
    "total_engaged_time_52_week_ago":"total number of seconds during which the user was engaged with the article, same day 52 weeks ago.",
    "affiliate_clicks_52_week_ago":"total number of clicks to affiliates, calculated as a count of 'ShoppingLinkTapEvents',same day 52 weeks ago.",
    "ecommerce_revenue_usd_constant_budget_adj_52_week_ago":"Affiliate commission converted to USD based on the changing budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 52 weeks ago.",
    "ecommerce_revenue_gbp_constant_budget_adj_52_week_ago":"Affiliate commission converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 52 weeks ago.",
    "ecommerce_sales_order_value_usd_constant_budget_adj_52_week_ago":"Sales order value converted to USD based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 52 weeks ago.",
    "ecommerce_sales_order_value_gbp_constant_budget_adj_52_week_ago":"Sales order value converted to GBP based on the constant budget exchange rate, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base same day 52 weeks ago.",
    "ecommerce_transactions_adj_52_week_ago":"Site level count of the number of transactions, adjusted based on the status of each transaction using safe rates associated with the merchant from ecommerce_revenue_base  same day 52 weeks ago.",
    "ads_impressions_52_week_ago":"Sum off impressions from unified_ads 52 weeks ago.",
    "ads_revenue_usd_daily_52_week_ago":"Sum of revenue from unified_ads 52 weeks ago.",
    "ads_revenue_gbp_daily_52_week_ago":"Sum of revenue converted into GBP. Using Netsuite exchange rates from unified_ads 52 weeks ago.",
    "ads_revenue_gbp_monthly_52_week_ago":"Same as above using exchange rate of the last day of the month from unified_ads 52 weeks ago."
  }
}
*/

/*
pre_operations {
  ${when(incremental(), `delete from ${self()} where date between ${constants.current_date_minus_90_day} and ${constants.current_date_minus_1_day}`)}
}
*/

with prod as(
select
ARRAY_TO_STRING(
[IFNULL(site_domain,'unknown'),
  IFNULL(parent_brand,'unknown')],
  "::")
  AS key_field,
  date,
  site_domain,
  parent_brand,
  users,
  nonsubscribed_users,
  subscribed_users,
  unique_pageviews,
  pageviews,
  affiliate_clicks,
  total_engaged_time,
  ecommerce_revenue_usd_constant_budget_adj ,
  ecommerce_revenue_gbp_constant_budget_adj,
  ecommerce_sales_order_value_usd_constant_budget_adj,
  ecommerce_sales_order_value_gbp_constant_budget_adj,
  ecommerce_transactions_adj,
  ads_impressions,
  ads_revenue_gbp_daily,
  ads_revenue_usd_daily,
  ads_revenue_gbp_monthly

  from ${ref("apple_news_stats_base")}

  WHERE
  ${when(incremental(),
        `date BETWEEN ${constants.current_date_minus_90_day} AND ${constants.current_date_minus_1_day}
        OR date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 1 DAY)
                  AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 1 DAY)
        OR date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 1 WEEK)
                  AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 1 WEEK)
        OR date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 2 WEEK)
                  AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 2 WEEK)
        OR date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 4 WEEK)
                  AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 4 WEEK)
        OR date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 52 WEEK)
                  AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 52 WEEK)`
        ,
        `date >= DATE_SUB(${constants.fy23_start}, INTERVAL 52 WEEK)`)}

  --group by ALL
)

,base AS (
  SELECT * FROM prod
  WHERE
    ${when(incremental(),
    `date BETWEEN ${constants.current_date_minus_90_day} AND ${constants.current_date_minus_1_day}`,
    `date >= ${constants.fy23_start}`)}
)

,one_week AS (
  SELECT * FROM prod
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 1 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 1 WEEK)`,
    `date >= DATE_SUB(${constants.fy23_start}, INTERVAL 1 WEEK)`)}
)

,two_week AS (
  SELECT * FROM prod
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 2 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 2 WEEK)`,
    `date >= DATE_SUB(${constants.fy23_start}, INTERVAL 2 WEEK)`)}
)

,four_week AS (
  SELECT * FROM prod
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 4 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 4 WEEK)`,
    `date >= DATE_SUB(${constants.fy23_start}, INTERVAL 4 WEEK)`)}
)

,fiftytwo_week AS (
  SELECT * FROM prod
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 52 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 52 WEEK)`,
    `date >= DATE_SUB(${constants.fy23_start}, INTERVAL 52 WEEK)`)}
)

,joined AS
(
    SELECT
      COALESCE (
        a.date
        ,DATE_ADD (one_week.date, INTERVAL 1 WEEK)
        ,DATE_ADD (two_week.date, INTERVAL 2 WEEK)
        ,DATE_ADD (four_week.date, INTERVAL 4 WEEK)
        ,DATE_ADD (fiftytwo_week.date, INTERVAL 52 WEEK)
        ) AS date
      ,COALESCE (a.key_field, one_week.key_field, two_week.key_field, four_week.key_field, fiftytwo_week.key_field) AS key_field
      ,COALESCE (a.site_domain, one_week.site_domain, two_week.site_domain, four_week.site_domain, fiftytwo_week.site_domain) AS site_domain
      ,COALESCE (a.parent_brand, one_week.parent_brand, two_week.parent_brand, four_week.parent_brand, fiftytwo_week.parent_brand) AS parent_brand

      ,IFNULL(SUM(a.users),0) AS users
      ,IFNULL(SUM(a.nonsubscribed_users),0) AS nonsubscribed_users
      ,IFNULL(SUM(a.subscribed_users),0) AS subscribed_users
      ,IFNULL(SUM(a.unique_pageviews),0) AS unique_pageviews
      ,IFNULL(SUM(a.pageviews),0) AS pageviews
      ,IFNULL(SUM(a.affiliate_clicks),0) AS affiliate_clicks
      ,IFNULL(SUM(a.total_engaged_time),0) AS total_engaged_time
      ,IFNULL(SUM(a.ecommerce_revenue_usd_constant_budget_adj),0) AS ecommerce_revenue_usd_constant_budget_adj
      ,IFNULL(SUM(a.ecommerce_revenue_gbp_constant_budget_adj),0) AS ecommerce_revenue_gbp_constant_budget_adj
      ,IFNULL(SUM(a.ecommerce_sales_order_value_usd_constant_budget_adj),0) AS ecommerce_sales_order_value_usd_constant_budget_adj
      ,IFNULL(SUM(a.ecommerce_sales_order_value_gbp_constant_budget_adj),0) AS  ecommerce_sales_order_value_gbp_constant_budget_adj
      ,IFNULL(SUM(a.ecommerce_transactions_adj),0) AS ecommerce_transactions_adj
      ,IFNULL(SUM(a.ads_impressions),0) AS ads_impressions
      ,IFNULL(SUM(a.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily
      ,IFNULL(SUM(a.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly
      ,IFNULL(SUM(a.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily


      -- PREVIOUS WEEK
      ,IFNULL(SUM(one_week.users),0) AS users_1_week_ago
      ,IFNULL(SUM(one_week.nonsubscribed_users),0) AS nonsubscribed_users_1_week_ago
      ,IFNULL(SUM(one_week.subscribed_users),0) AS subscribed_users_1_week_ago
      ,IFNULL(SUM(one_week.unique_pageviews),0) AS unique_pageviews_1_week_ago
      ,IFNULL(SUM(one_week.pageviews),0) AS pageviews_1_week_ago
      ,IFNULL(SUM(one_week.affiliate_clicks),0) AS affiliate_clicks_1_week_ago
      ,IFNULL(SUM(one_week.total_engaged_time),0) AS total_engaged_time_1_week_ago
      ,IFNULL(SUM(one_week.ecommerce_revenue_usd_constant_budget_adj),0) AS ecommerce_revenue_usd_constant_budget_adj_1_week_ago
      ,IFNULL(SUM(one_week.ecommerce_revenue_gbp_constant_budget_adj),0) AS ecommerce_revenue_gbp_constant_budget_adj_1_week_ago
      ,IFNULL(SUM(one_week.ecommerce_sales_order_value_usd_constant_budget_adj),0) AS ecommerce_sales_order_value_usd_constant_budget_adj_1_week_ago
      ,IFNULL(SUM(one_week.ecommerce_sales_order_value_gbp_constant_budget_adj),0) AS  ecommerce_sales_order_value_gbp_constant_budget_adj_1_week_ago
      ,IFNULL(SUM(one_week.ecommerce_transactions_adj),0) AS ecommerce_transactions_adj_1_week_ago
      ,IFNULL(SUM(one_week.ads_impressions),0) AS ads_impressions_1_week_ago
      ,IFNULL(SUM(one_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_1_week_ago
      ,IFNULL(SUM(one_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_1_week_ago
      ,IFNULL(SUM(one_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_1_week_ago

      -- TWO WEEKS AGO
      ,IFNULL(SUM(two_week.users),0) AS users_2_week_ago
      ,IFNULL(SUM(two_week.nonsubscribed_users),0) AS nonsubscribed_users_2_week_ago
      ,IFNULL(SUM(two_week.subscribed_users),0) AS subscribed_users_2_week_ago
      ,IFNULL(SUM(two_week.unique_pageviews),0) AS unique_pageviews_2_week_ago
      ,IFNULL(SUM(two_week.pageviews),0) AS pageviews_2_week_ago
      ,IFNULL(SUM(two_week.affiliate_clicks),0) AS affiliate_clicks_2_week_ago
      ,IFNULL(SUM(two_week.total_engaged_time),0) AS total_engaged_time_2_week_ago
      ,IFNULL(SUM(two_week.ecommerce_revenue_usd_constant_budget_adj),0) AS ecommerce_revenue_usd_constant_budget_adj_2_week_ago
      ,IFNULL(SUM(two_week.ecommerce_revenue_gbp_constant_budget_adj),0) AS ecommerce_revenue_gbp_constant_budget_adj_2_week_ago
      ,IFNULL(SUM(two_week.ecommerce_sales_order_value_usd_constant_budget_adj),0) AS ecommerce_sales_order_value_usd_constant_budget_adj_2_week_ago
      ,IFNULL(SUM(two_week.ecommerce_sales_order_value_gbp_constant_budget_adj),0) AS  ecommerce_sales_order_value_gbp_constant_budget_adj_2_week_ago
      ,IFNULL(SUM(two_week.ecommerce_transactions_adj),0) AS ecommerce_transactions_adj_2_week_ago
      ,IFNULL(SUM(two_week.ads_impressions),0) AS ads_impressions_2_week_ago
      ,IFNULL(SUM(two_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_2_week_ago
      ,IFNULL(SUM(two_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_2_week_ago
      ,IFNULL(SUM(two_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_2_week_ago

      -- FOUR WEEKS AGO
      ,IFNULL(SUM(four_week.users),0) AS users_4_week_ago
      ,IFNULL(SUM(four_week.nonsubscribed_users),0) AS nonsubscribed_users_4_week_ago
      ,IFNULL(SUM(four_week.subscribed_users),0) AS subscribed_users_4_week_ago
      ,IFNULL(SUM(four_week.unique_pageviews),0) AS unique_pageviews_4_week_ago
      ,IFNULL(SUM(four_week.pageviews),0) AS pageviews_4_week_ago
      ,IFNULL(SUM(four_week.affiliate_clicks),0) AS affiliate_clicks_4_week_ago
      ,IFNULL(SUM(four_week.total_engaged_time),0) AS total_engaged_time_4_week_ago
      ,IFNULL(SUM(four_week.ecommerce_revenue_usd_constant_budget_adj),0) AS ecommerce_revenue_usd_constant_budget_adj_4_week_ago
      ,IFNULL(SUM(four_week.ecommerce_revenue_gbp_constant_budget_adj),0) AS ecommerce_revenue_gbp_constant_budget_adj_4_week_ago
      ,IFNULL(SUM(four_week.ecommerce_sales_order_value_usd_constant_budget_adj),0) AS ecommerce_sales_order_value_usd_constant_budget_adj_4_week_ago
      ,IFNULL(SUM(four_week.ecommerce_sales_order_value_gbp_constant_budget_adj),0) AS  ecommerce_sales_order_value_gbp_constant_budget_adj_4_week_ago
      ,IFNULL(SUM(four_week.ecommerce_transactions_adj),0) AS ecommerce_transactions_adj_4_week_ago
      ,IFNULL(SUM(four_week.ads_impressions),0) AS ads_impressions_4_week_ago
      ,IFNULL(SUM(four_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_4_week_ago
      ,IFNULL(SUM(four_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_4_week_ago
      ,IFNULL(SUM(four_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_4_week_ago

      -- FIFTY TWO WEEKS AGO
      ,IFNULL(SUM(fiftytwo_week.users),0) AS users_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.nonsubscribed_users),0) AS nonsubscribed_users_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.subscribed_users),0) AS subscribed_users_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.unique_pageviews),0) AS unique_pageviews_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.pageviews),0) AS pageviews_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.affiliate_clicks),0) AS affiliate_clicks_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.total_engaged_time),0) AS total_engaged_time_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ecommerce_revenue_usd_constant_budget_adj),0) AS ecommerce_revenue_usd_constant_budget_adj_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ecommerce_revenue_gbp_constant_budget_adj),0) AS ecommerce_revenue_gbp_constant_budget_adj_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ecommerce_sales_order_value_usd_constant_budget_adj),0) AS ecommerce_sales_order_value_usd_constant_budget_adj_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ecommerce_sales_order_value_gbp_constant_budget_adj),0) AS  ecommerce_sales_order_value_gbp_constant_budget_adj_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ecommerce_transactions_adj),0) AS ecommerce_transactions_adj_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ads_impressions),0) AS ads_impressions_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_52_week_ago
      ,IFNULL(SUM(fiftytwo_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_52_week_ago

        FROM base as a
  JOIN ${ref("calendar")} as cal on cal.date = a.date

    --1 week
    FULL JOIN one_week
        ON one_week.key_field = a.key_field
        AND one_week.date = cal.one_week_date
    --2 weeks
    FULL JOIN two_week
        ON two_week.key_field = a.key_field
        AND two_week.date = cal.two_week_date
    --4 weeks
    FULL JOIN four_week
        ON four_week.key_field = a.key_field
        AND four_week.date = cal.four_week_date
    --52 weeks
    FULL JOIN fiftytwo_week
        ON fiftytwo_week.key_field = a.key_field
        AND fiftytwo_week.date = cal.fiftytwo_week_date

    GROUP BY ALL

    HAVING
      date BETWEEN ${when(incremental(),`${constants.current_date_minus_90_day}`,`${constants.fy23_start}`)}
      AND  ${constants.current_date_minus_1_day}
  )

SELECT
    SHA256(
      ARRAY_TO_STRING
        (
          [
            CAST (date as STRING)
            ,key_field
          ]
      ,""
      )
    ) AS hash_key,
    date,
    site_domain,
    parent_brand,
    users,
    nonsubscribed_users,
    subscribed_users,
    unique_pageviews,
    pageviews,
    affiliate_clicks,
    total_engaged_time,
    ecommerce_revenue_usd_constant_budget_adj ,
    ecommerce_revenue_gbp_constant_budget_adj,
    ecommerce_sales_order_value_usd_constant_budget_adj,
    ecommerce_sales_order_value_gbp_constant_budget_adj,
    ecommerce_transactions_adj,
    ads_impressions,
    ads_revenue_gbp_daily,
    ads_revenue_usd_daily,
    ads_revenue_gbp_monthly,
    users_1_week_ago,
    nonsubscribed_users_1_week_ago,
    subscribed_users_1_week_ago,
    unique_pageviews_1_week_ago,
    pageviews_1_week_ago,
    affiliate_clicks_1_week_ago,
    total_engaged_time_1_week_ago,
    ecommerce_revenue_usd_constant_budget_adj_1_week_ago ,
    ecommerce_revenue_gbp_constant_budget_adj_1_week_ago,
    ecommerce_sales_order_value_usd_constant_budget_adj_1_week_ago,
    ecommerce_sales_order_value_gbp_constant_budget_adj_1_week_ago,
    ecommerce_transactions_adj_1_week_ago,
    ads_impressions_1_week_ago,
    ads_revenue_gbp_daily_1_week_ago,
    ads_revenue_usd_daily_1_week_ago,
    ads_revenue_gbp_monthly_1_week_ago,
    users_2_week_ago,
    nonsubscribed_users_2_week_ago,
    subscribed_users_2_week_ago,
    unique_pageviews_2_week_ago,
    pageviews_2_week_ago,
    affiliate_clicks_2_week_ago,
    total_engaged_time_2_week_ago,
    ecommerce_revenue_usd_constant_budget_adj_2_week_ago ,
    ecommerce_revenue_gbp_constant_budget_adj_2_week_ago,
    ecommerce_sales_order_value_usd_constant_budget_adj_2_week_ago,
    ecommerce_sales_order_value_gbp_constant_budget_adj_2_week_ago,
    ecommerce_transactions_adj_2_week_ago,
    ads_impressions_2_week_ago,
    ads_revenue_gbp_daily_2_week_ago,
    ads_revenue_usd_daily_2_week_ago,
    ads_revenue_gbp_monthly_2_week_ago,
    users_4_week_ago,
    nonsubscribed_users_4_week_ago,
    subscribed_users_4_week_ago,
    unique_pageviews_4_week_ago,
    pageviews_4_week_ago,
    affiliate_clicks_4_week_ago,
    total_engaged_time_4_week_ago,
    ecommerce_revenue_usd_constant_budget_adj_4_week_ago ,
    ecommerce_revenue_gbp_constant_budget_adj_4_week_ago,
    ecommerce_sales_order_value_usd_constant_budget_adj_4_week_ago,
    ecommerce_sales_order_value_gbp_constant_budget_adj_4_week_ago,
    ecommerce_transactions_adj_4_week_ago,
    ads_impressions_4_week_ago,
    ads_revenue_gbp_daily_4_week_ago,
    ads_revenue_usd_daily_4_week_ago,
    ads_revenue_gbp_monthly_4_week_ago,
    users_52_week_ago,
    nonsubscribed_users_52_week_ago,
    subscribed_users_52_week_ago,
    unique_Pageviews_52_week_ago,
    pageviews_52_week_ago,
    affiliate_clicks_52_week_ago,
    total_engaged_time_52_week_ago,
    ecommerce_revenue_usd_constant_budget_adj_52_week_ago ,
    ecommerce_revenue_gbp_constant_budget_adj_52_week_ago,
    ecommerce_sales_order_value_usd_constant_budget_adj_52_week_ago,
    ecommerce_sales_order_value_gbp_constant_budget_adj_52_week_ago,
    ecommerce_transactions_adj_52_week_ago,
    ads_impressions_52_week_ago,
    ads_revenue_gbp_daily_52_week_ago,
    ads_revenue_usd_daily_52_week_ago,
    ads_revenue_gbp_monthly_52_week_ago

      FROM
    joined