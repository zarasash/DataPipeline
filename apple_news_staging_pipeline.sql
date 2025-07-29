
-- Apple News Data Pipeline (Converted from Dataform SQLX)

-- Original Dataform config block removed for clarity
-- Refer to the GitHub project README for schema, description, and notes

WITH apple_data AS (
  SELECT
    DATE(openedAt) AS date,
    DATE(ingestion_time) AS ingestionDate,
    siteid AS site,
    IFNULL(geo, '') AS country,
    IFNULL(devicemodel, '') AS deviceType,
    IFNULL(referralsource, '') AS referralSource,
    articleid AS appleArticleId,
    IFNULL(articleurl, '') AS appleArticleUrl,
    IFNULL(title, '') AS appleArticleTitle,
    contenttype AS appleContentType,
    IFNULL(ispromoted, FALSE) AS isPromoted,
    IFNULL(issponsored, FALSE) AS isSponsored,
    IFNULL(ispaywalled, FALSE) AS isPaywalled,
    IFNULL(isaudioarticle, FALSE) AS isAudioArticle,
    IFNULL(hasvideo, FALSE) AS hasVideo,
    userid AS userId,
    subscribertype AS subscriberType,
    viewid AS viewId,
    engagedtime AS engagedTime,
    eventtype AS eventType,
    ARRAY_LENGTH(ShoppingLinkTapEvents) AS affiliateClicks,
    ROW_NUMBER() OVER (
      PARTITION BY
        siteid, geo, devicemodel, referralsource, viewid, userid, articleid, title, contenttype, articleurl,
        ispromoted, issponsored, ispaywalled, isaudioarticle, hasvideo, subscribertype, timestamp 
      ORDER BY ingestion_time DESC
    ) AS row_num
  FROM `future_dataengineering_applenews_v1beta_LogEvent`,
  UNNEST(events) AS eve
  WHERE
    eventtype = "ARTICLE_VIEW_EVENT"
    AND DATE(ingestion_time) BETWEEN @apple_news_traffic_start AND @apple_news_traffic_end
)

SELECT 
  date,
  ingestionDate,
  site,
  country,
  deviceType,
  referralSource,
  appleArticleId,
  appleArticleUrl,
  appleContentType,
  appleArticleTitle,
  isPromoted,
  isSponsored,
  isPaywalled,
  isAudioArticle,
  hasVideo,
  userId,
  subscriberType,
  viewId,
  SUM(affiliateClicks) AS affiliateClicks,
  SUM(engagedTime) AS engagedTime
FROM apple_data
WHERE row_num = 1
GROUP BY ALL;
