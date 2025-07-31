/*
Anonymized Dataform Configuration for Public Sharing
This configuration block has been generalized to remove specific business logic and proprietary naming.
The purpose is to demonstrate a common data transformation and aggregation pattern.
*/
config {
  type: "incremental",
  schema: "analytics_core",
  tags: ["platform-analysis", "weekly-refresh"],
  protected: false,
  uniqueKey: ["hash_key"],
  assertions: {
    nonNull: [ "parent_brand"]
  },
  bigquery: {
    partitionBy: "date",
    updatePartitionFilter: "date>= DATE_SUB(current_date(), INTERVAL 90 DAY)",
    clusterBy: ["parent_brand", "site_domain"],
    labels: {
      "managed-by": "dataform"
    }
  },
  description: "Daily aggregations and comparisons of content, commerce, and ad data.",
  columns: {
    "hash_key":"A unique identifier combining date, brand, and site domain.",
    "date": "The day of the event, in YYYY-MM-DD format.",
    "site_domain":"The clean website domain without 'www' or a trailing slash.",
    "parent_brand":"The parent brand associated with the site, joined via a mapping table.",
    "users":"A count of distinct user identifiers.",
    "free_tier_users":"A count of distinct users identified as free-tier members.",
    "premium_users":"A count of distinct users identified as premium-tier members.",
    "unique_pageviews":"A count of distinct, de-duped session IDs for content view events.",
    "pageviews":"A count of all session IDs for content view events.",
    "total_engagement_time":"The total number of seconds a user was engaged with the content.",
    "call_to_action_clicks":"The total number of clicks on affiliate or commerce links.",
    "commerce_revenue_usd":"Revenue from commerce, converted to USD.",
    "commerce_revenue_gbp":"Revenue from commerce, converted to GBP.",
    "commerce_sales_order_value_usd":"Sales order value, converted to USD.",
    "commerce_sales_order_value_gbp":"Sales order value, converted to GBP.",
    "commerce_transactions":"A count of the number of transactions.",
    "ads_impressions":"The sum of ad impressions.",
    "ads_revenue_usd_daily":"The sum of ad revenue in USD on a daily basis.",
    "ads_revenue_gbp_daily":"The sum of ad revenue in GBP on a daily basis.",
    "ads_revenue_gbp_monthly":"The sum of ad revenue in GBP, using a monthly exchange rate.",
    "users_1_week_ago":"A count of distinct users from one week prior.",
    "free_tier_users_1_week_ago":"A count of distinct free-tier users from one week prior.",
    "premium_users_1_week_ago":"A count of distinct premium-tier users from one week prior.",
    "unique_pageviews_1_week_ago":"A count of distinct pageviews from one week prior.",
    "pageviews_1_week_ago":"A count of all pageviews from one week prior.",
    "total_engagement_time_1_week_ago":"The total engagement time from one week prior.",
    "call_to_action_clicks_1_week_ago":"The total number of clicks from one week prior.",
    "commerce_revenue_usd_1_week_ago":"Commerce revenue in USD from one week prior.",
    "commerce_revenue_gbp_1_week_ago":"Commerce revenue in GBP from one week prior.",
    "commerce_sales_order_value_usd_1_week_ago":"Sales order value in USD from one week prior.",
    "commerce_sales_order_value_gbp_1_week_ago":"Sales order value in GBP from one week prior.",
    "commerce_transactions_1_week_ago":"The count of transactions from one week prior.",
    "ads_impressions_1_week_ago":"Ad impressions from one week prior.",
    "ads_revenue_usd_daily_1_week_ago":"Daily ad revenue in USD from one week prior.",
    "ads_revenue_gbp_daily_1_week_ago":"Daily ad revenue in GBP from one week prior.",
    "ads_revenue_gbp_monthly_1_week_ago":"Monthly ad revenue in GBP from one week prior.",
    "users_2_week_ago":"A count of distinct users from two weeks prior.",
    "free_tier_users_2_week_ago":"A count of distinct free-tier users from two weeks prior.",
    "premium_users_2_week_ago":"A count of distinct premium-tier users from two weeks prior.",
    "unique_pageviews_2_week_ago":"A count of distinct pageviews from two weeks prior.",
    "pageviews_2_week_ago":"A count of all pageviews from two weeks prior.",
    "total_engagement_time_2_week_ago":"The total engagement time from two weeks prior.",
    "call_to_action_clicks_2_week_ago":"The total number of clicks from two weeks prior.",
    "commerce_revenue_usd_2_week_ago":"Commerce revenue in USD from two weeks prior.",
    "commerce_revenue_gbp_2_week_ago":"Commerce revenue in GBP from two weeks prior.",
    "commerce_sales_order_value_usd_2_week_ago":"Sales order value in USD from two weeks prior.",
    "commerce_sales_order_value_gbp_2_week_ago":"Sales order value in GBP from two weeks prior.",
    "commerce_transactions_2_week_ago":"The count of transactions from two weeks prior.",
    "ads_impressions_2_week_ago":"Ad impressions from two weeks prior.",
    "ads_revenue_usd_daily_2_week_ago":"Daily ad revenue in USD from two weeks prior.",
    "ads_revenue_gbp_daily_2_week_ago":"Daily ad revenue in GBP from two weeks prior.",
    "ads_revenue_gbp_monthly_2_week_ago":"Monthly ad revenue in GBP from two weeks prior.",
    "users_4_week_ago":"A count of distinct users from four weeks prior.",
    "free_tier_users_4_week_ago":"A count of distinct free-tier users from four weeks prior.",
    "premium_users_4_week_ago":"A count of distinct premium-tier users from four weeks prior.",
    "unique_pageviews_4_week_ago":"A count of distinct pageviews from four weeks prior.",
    "pageviews_4_week_ago":"A count of all pageviews from four weeks prior.",
    "total_engagement_time_4_week_ago":"The total engagement time from four weeks prior.",
    "call_to_action_clicks_4_week_ago":"The total number of clicks from four weeks prior.",
    "commerce_revenue_usd_4_week_ago":"Commerce revenue in USD from four weeks prior.",
    "commerce_revenue_gbp_4_week_ago":"Commerce revenue in GBP from four weeks prior.",
    "commerce_sales_order_value_usd_4_week_ago":"Sales order value in USD from four weeks prior.",
    "commerce_sales_order_value_gbp_4_week_ago":"Sales order value in GBP from four weeks prior.",
    "commerce_transactions_4_week_ago":"The count of transactions from four weeks prior.",
    "ads_impressions_4_week_ago":"Ad impressions from four weeks prior.",
    "ads_revenue_usd_daily_4_week_ago":"Daily ad revenue in USD from four weeks prior.",
    "ads_revenue_gbp_daily_4_week_ago":"Daily ad revenue in GBP from four weeks prior.",
    "ads_revenue_gbp_monthly_4_week_ago":"Monthly ad revenue in GBP from four weeks prior.",
    "users_52_week_ago":"A count of distinct users from 52 weeks prior.",
    "free_tier_users_52_week_ago":"A count of distinct free-tier users from 52 weeks prior.",
    "premium_users_52_week_ago":"A count of distinct premium-tier users from 52 weeks prior.",
    "unique_pageviews_52_week_ago":"A count of distinct pageviews from 52 weeks prior.",
    "pageviews_52_week_ago":"A count of all pageviews from 52 weeks prior.",
    "total_engagement_time_52_week_ago":"The total engagement time from 52 weeks prior.",
    "call_to_action_clicks_52_week_ago":"The total number of clicks from 52 weeks prior.",
    "commerce_revenue_usd_52_week_ago":"Commerce revenue in USD from 52 weeks prior.",
    "commerce_revenue_gbp_52_week_ago":"Commerce revenue in GBP from 52 weeks prior.",
    "commerce_sales_order_value_usd_52_week_ago":"Sales order value in USD from 52 weeks prior.",
    "commerce_sales_order_value_gbp_52_week_ago":"Sales order value in GBP from 52 weeks prior.",
    "commerce_transactions_52_week_ago":"The count of transactions from 52 weeks prior.",
    "ads_impressions_52_week_ago":"Ad impressions from 52 weeks prior.",
    "ads_revenue_usd_daily_52_week_ago":"Daily ad revenue in USD from 52 weeks prior.",
    "ads_revenue_gbp_daily_52_week_ago":"Daily ad revenue in GBP from 52 weeks prior.",
    "ads_revenue_gbp_monthly_52_week_ago":"Monthly ad revenue in GBP from 52 weeks prior."
  }
}
*/

/*
pre_operations {
  -- This pre-operation deletes data from the last 90 days to prepare for an incremental update.
  ${when(incremental(), `delete from ${self()} where date between ${constants.current_date_minus_90_day} and ${constants.current_date_minus_1_day}`)}
}
*/

with current_metrics as(
  select
    ARRAY_TO_STRING(
      [IFNULL(site_domain,'unknown'),
      IFNULL(parent_brand,'unknown')],
      "::") AS key_field,
    date,
    site_domain,
    parent_brand,
    users,
    free_tier_users,
    premium_users,
    unique_pageviews,
    pageviews,
    call_to_action_clicks,
    total_engagement_time,
    commerce_revenue_usd ,
    commerce_revenue_gbp,
    commerce_sales_order_value_usd,
    commerce_sales_order_value_gbp,
    commerce_transactions,
    ads_impressions,
    ads_revenue_gbp_daily,
    ads_revenue_usd_daily,
    ads_revenue_gbp_monthly
  from ${ref("combined_metrics_base")}

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
        `date >= DATE_SUB(${constants.start_of_fiscal_year}, INTERVAL 52 WEEK)`)}
)

,base AS (
  SELECT * FROM current_metrics
  WHERE
    ${when(incremental(),
    `date BETWEEN ${constants.current_date_minus_90_day} AND ${constants.current_date_minus_1_day}`,
    `date >= ${constants.start_of_fiscal_year}`)}
)

,one_week AS (
  SELECT * FROM current_metrics
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 1 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 1 WEEK)`,
    `date >= DATE_SUB(${constants.start_of_fiscal_year}, INTERVAL 1 WEEK)`)}
)

,two_week AS (
  SELECT * FROM current_metrics
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 2 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 2 WEEK)`,
    `date >= DATE_SUB(${constants.start_of_fiscal_year}, INTERVAL 2 WEEK)`)}
)

,four_week AS (
  SELECT * FROM current_metrics
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 4 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 4 WEEK)`,
    `date >= DATE_SUB(${constants.start_of_fiscal_year}, INTERVAL 4 WEEK)`)}
)

,fiftytwo_week AS (
  SELECT * FROM current_metrics
  WHERE
    ${when(incremental(),
    `date BETWEEN DATE_SUB(${constants.current_date_minus_90_day}, INTERVAL 52 WEEK) AND DATE_SUB(${constants.current_date_minus_1_day}, INTERVAL 52 WEEK)`,
    `date >= DATE_SUB(${constants.start_of_fiscal_year}, INTERVAL 52 WEEK)`)}
)

,joined AS (
  SELECT
    COALESCE(
      a.date
      ,DATE_ADD(one_week.date, INTERVAL 1 WEEK)
      ,DATE_ADD(two_week.date, INTERVAL 2 WEEK)
      ,DATE_ADD(four_week.date, INTERVAL 4 WEEK)
      ,DATE_ADD(fiftytwo_week.date, INTERVAL 52 WEEK)
      ) AS date
    ,COALESCE(a.key_field, one_week.key_field, two_week.key_field, four_week.key_field, fiftytwo_week.key_field) AS key_field
    ,COALESCE(a.site_domain, one_week.site_domain, two_week.site_domain, four_week.site_domain, fiftytwo_week.site_domain) AS site_domain
    ,COALESCE(a.parent_brand, one_week.parent_brand, two_week.parent_brand, four_week.parent_brand, fiftytwo_week.parent_brand) AS parent_brand

    ,IFNULL(SUM(a.users),0) AS users
    ,IFNULL(SUM(a.free_tier_users),0) AS free_tier_users
    ,IFNULL(SUM(a.premium_users),0) AS premium_users
    ,IFNULL(SUM(a.unique_pageviews),0) AS unique_pageviews
    ,IFNULL(SUM(a.pageviews),0) AS pageviews
    ,IFNULL(SUM(a.call_to_action_clicks),0) AS call_to_action_clicks
    ,IFNULL(SUM(a.total_engagement_time),0) AS total_engagement_time
    ,IFNULL(SUM(a.commerce_revenue_usd),0) AS commerce_revenue_usd
    ,IFNULL(SUM(a.commerce_revenue_gbp),0) AS commerce_revenue_gbp
    ,IFNULL(SUM(a.commerce_sales_order_value_usd),0) AS commerce_sales_order_value_usd
    ,IFNULL(SUM(a.commerce_sales_order_value_gbp),0) AS  commerce_sales_order_value_gbp
    ,IFNULL(SUM(a.commerce_transactions),0) AS commerce_transactions
    ,IFNULL(SUM(a.ads_impressions),0) AS ads_impressions
    ,IFNULL(SUM(a.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily
    ,IFNULL(SUM(a.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly
    ,IFNULL(SUM(a.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily


    -- PREVIOUS WEEK
    ,IFNULL(SUM(one_week.users),0) AS users_1_week_ago
    ,IFNULL(SUM(one_week.free_tier_users),0) AS free_tier_users_1_week_ago
    ,IFNULL(SUM(one_week.premium_users),0) AS premium_users_1_week_ago
    ,IFNULL(SUM(one_week.unique_pageviews),0) AS unique_pageviews_1_week_ago
    ,IFNULL(SUM(one_week.pageviews),0) AS pageviews_1_week_ago
    ,IFNULL(SUM(one_week.call_to_action_clicks),0) AS call_to_action_clicks_1_week_ago
    ,IFNULL(SUM(one_week.total_engagement_time),0) AS total_engagement_time_1_week_ago
    ,IFNULL(SUM(one_week.commerce_revenue_usd),0) AS commerce_revenue_usd_1_week_ago
    ,IFNULL(SUM(one_week.commerce_revenue_gbp),0) AS commerce_revenue_gbp_1_week_ago
    ,IFNULL(SUM(one_week.commerce_sales_order_value_usd),0) AS commerce_sales_order_value_usd_1_week_ago
    ,IFNULL(SUM(one_week.commerce_sales_order_value_gbp),0) AS  commerce_sales_order_value_gbp_1_week_ago
    ,IFNULL(SUM(one_week.commerce_transactions),0) AS commerce_transactions_1_week_ago
    ,IFNULL(SUM(one_week.ads_impressions),0) AS ads_impressions_1_week_ago
    ,IFNULL(SUM(one_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_1_week_ago
    ,IFNULL(SUM(one_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_1_week_ago
    ,IFNULL(SUM(one_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_1_week_ago

    -- TWO WEEKS AGO
    ,IFNULL(SUM(two_week.users),0) AS users_2_week_ago
    ,IFNULL(SUM(two_week.free_tier_users),0) AS free_tier_users_2_week_ago
    ,IFNULL(SUM(two_week.premium_users),0) AS premium_users_2_week_ago
    ,IFNULL(SUM(two_week.unique_pageviews),0) AS unique_pageviews_2_week_ago
    ,IFNULL(SUM(two_week.pageviews),0) AS pageviews_2_week_ago
    ,IFNULL(SUM(two_week.call_to_action_clicks),0) AS call_to_action_clicks_2_week_ago
    ,IFNULL(SUM(two_week.total_engagement_time),0) AS total_engagement_time_2_week_ago
    ,IFNULL(SUM(two_week.commerce_revenue_usd),0) AS commerce_revenue_usd_2_week_ago
    ,IFNULL(SUM(two_week.commerce_revenue_gbp),0) AS commerce_revenue_gbp_2_week_ago
    ,IFNULL(SUM(two_week.commerce_sales_order_value_usd),0) AS commerce_sales_order_value_usd_2_week_ago
    ,IFNULL(SUM(two_week.commerce_sales_order_value_gbp),0) AS  commerce_sales_order_value_gbp_2_week_ago
    ,IFNULL(SUM(two_week.commerce_transactions),0) AS commerce_transactions_2_week_ago
    ,IFNULL(SUM(two_week.ads_impressions),0) AS ads_impressions_2_week_ago
    ,IFNULL(SUM(two_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_2_week_ago
    ,IFNULL(SUM(two_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_2_week_ago
    ,IFNULL(SUM(two_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_2_week_ago

    -- FOUR WEEKS AGO
    ,IFNULL(SUM(four_week.users),0) AS users_4_week_ago
    ,IFNULL(SUM(four_week.free_tier_users),0) AS free_tier_users_4_week_ago
    ,IFNULL(SUM(four_week.premium_users),0) AS premium_users_4_week_ago
    ,IFNULL(SUM(four_week.unique_pageviews),0) AS unique_pageviews_4_week_ago
    ,IFNULL(SUM(four_week.pageviews),0) AS pageviews_4_week_ago
    ,IFNULL(SUM(four_week.call_to_action_clicks),0) AS call_to_action_clicks_4_week_ago
    ,IFNULL(SUM(four_week.total_engagement_time),0) AS total_engagement_time_4_week_ago
    ,IFNULL(SUM(four_week.commerce_revenue_usd),0) AS commerce_revenue_usd_4_week_ago
    ,IFNULL(SUM(four_week.commerce_revenue_gbp),0) AS commerce_revenue_gbp_4_week_ago
    ,IFNULL(SUM(four_week.commerce_sales_order_value_usd),0) AS commerce_sales_order_value_usd_4_week_ago
    ,IFNULL(SUM(four_week.commerce_sales_order_value_gbp),0) AS  commerce_sales_order_value_gbp_4_week_ago
    ,IFNULL(SUM(four_week.commerce_transactions),0) AS commerce_transactions_4_week_ago
    ,IFNULL(SUM(four_week.ads_impressions),0) AS ads_impressions_4_week_ago
    ,IFNULL(SUM(four_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_4_week_ago
    ,IFNULL(SUM(four_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_4_week_ago
    ,IFNULL(SUM(four_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_4_week_ago

    -- FIFTY TWO WEEKS AGO
    ,IFNULL(SUM(fiftytwo_week.users),0) AS users_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.free_tier_users),0) AS free_tier_users_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.premium_users),0) AS premium_users_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.unique_pageviews),0) AS unique_pageviews_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.pageviews),0) AS pageviews_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.call_to_action_clicks),0) AS call_to_action_clicks_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.total_engagement_time),0) AS total_engagement_time_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.commerce_revenue_usd),0) AS commerce_revenue_usd_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.commerce_revenue_gbp),0) AS commerce_revenue_gbp_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.commerce_sales_order_value_usd),0) AS commerce_sales_order_value_usd_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.commerce_sales_order_value_gbp),0) AS  commerce_sales_order_value_gbp_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.commerce_transactions),0) AS commerce_transactions_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.ads_impressions),0) AS ads_impressions_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.ads_revenue_gbp_daily),0) AS ads_revenue_gbp_daily_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.ads_revenue_usd_daily),0) AS ads_revenue_usd_daily_52_week_ago
    ,IFNULL(SUM(fiftytwo_week.ads_revenue_gbp_monthly),0) AS ads_revenue_gbp_monthly_52_week_ago

  FROM base as a
  JOIN ${ref("calendar")} as cal on cal.date = a.date

  -- Join with previous periods using the anonymized key
  FULL JOIN one_week
    ON one_week.key_field = a.key_field
    AND one_week.date = cal.one_week_date
  FULL JOIN two_week
    ON two_week.key_field = a.key_field
    AND two_week.date = cal.two_week_date
  FULL JOIN four_week
    ON four_week.key_field = a.key_field
    AND four_week.date = cal.four_week_date
  FULL JOIN fiftytwo_week
    ON fiftytwo_week.key_field = a.key_field
    AND fiftytwo_week.date = cal.fiftytwo_week_date

  GROUP BY ALL

  HAVING
    date BETWEEN ${when(incremental(),`${constants.current_date_minus_90_day}`,`${constants.start_of_fiscal_year}`)}
    AND  ${constants.current_date_minus_1_day}
)

SELECT
  -- Generate a hash key for a unique, anonymized row identifier
  SHA256(
    ARRAY_TO_STRING
      (
        [
          CAST(date as STRING)
          ,key_field
        ]
    ,""
    )
  ) AS hash_key,
  date,
  site_domain,
  parent_brand,
  users,
  free_tier_users,
  premium_users,
  unique_pageviews,
  pageviews,
  call_to_action_clicks,
  total_engagement_time,
  commerce_revenue_usd,
  commerce_revenue_gbp,
  commerce_sales_order_value_usd,
  commerce_sales_order_value_gbp,
  commerce_transactions,
  ads_impressions,
  ads_revenue_gbp_daily,
  ads_revenue_usd_daily,
  ads_revenue_gbp_monthly,
  users_1_week_ago,
  free_tier_users_1_week_ago,
  premium_users_1_week_ago,
  unique_pageviews_1_week_ago,
  pageviews_1_week_ago,
  call_to_action_clicks_1_week_ago,
  total_engagement_time_1_week_ago,
  commerce_revenue_usd_1_week_ago,
  commerce_revenue_gbp_1_week_ago,
  commerce_sales_order_value_usd_1_week_ago,
  commerce_sales_order_value_gbp_1_week_ago,
  commerce_transactions_1_week_ago,
  ads_impressions_1_week_ago,
  ads_revenue_gbp_daily_1_week_ago,
  ads_revenue_usd_daily_1_week_ago,
  ads_revenue_gbp_monthly_1_week_ago,
  users_2_week_ago,
  free_tier_users_2_week_ago,
  premium_users_2_week_ago,
  unique_pageviews_2_week_ago,
  pageviews_2_week_ago,
  call_to_action_clicks_2_week_ago,
  total_engagement_time_2_week_ago,
  commerce_revenue_usd_2_week_ago,
  commerce_revenue_gbp_2_week_ago,
  commerce_sales_order_value_usd_2_week_ago,
  commerce_sales_order_value_gbp_2_week_ago,
  commerce_transactions_2_week_ago,
  ads_impressions_2_week_ago,
  ads_revenue_gbp_daily_2_week_ago,
  ads_revenue_usd_daily_2_week_ago,
  ads_revenue_gbp_monthly_2_week_ago,
  users_4_week_ago,
  free_tier_users_4_week_ago,
  premium_users_4_week_ago,
  unique_pageviews_4_week_ago,
  pageviews_4_week_ago,
  call_to_action_clicks_4_week_ago,
  total_engagement_time_4_week_ago,
  commerce_revenue_usd_4_week_ago,
  commerce_revenue_gbp_4_week_ago,
  commerce_sales_order_value_usd_4_week_ago,
  commerce_sales_order_value_gbp_4_week_ago,
  commerce_transactions_4_week_ago,
  ads_impressions_4_week_ago,
  ads_revenue_gbp_daily_4_week_ago,
  ads_revenue_usd_daily_4_week_ago,
  ads_revenue_gbp_monthly_4_week_ago,
  users_52_week_ago,
  free_tier_users_52_week_ago,
  premium_users_52_week_ago,
  unique_pageviews_52_week_ago,
  pageviews_52_week_ago,
  call_to_action_clicks_52_week_ago,
  total_engagement_time_52_week_ago,
  commerce_revenue_usd_52_week_ago,
  commerce_revenue_gbp_52_week_ago,
  commerce_sales_order_value_usd_52_week_ago,
  commerce_sales_order_value_gbp_52_week_ago,
  commerce_transactions_52_week_ago,
  ads_impressions_52_week_ago,
  ads_revenue_gbp_daily_52_week_ago,
  ads_revenue_usd_daily_52_week_ago,
  ads_revenue_gbp_monthly_52_week_ago
FROM joined
