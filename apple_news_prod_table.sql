
-- Apple News Production Table (Converted from Dataform SQLX)
-- Description: Apple News Stats production

-- NOTE:
-- The `pre_operations` logic for deleting overlapping dates during incremental runs
-- should be handled in orchestration or staging prior to final table write.

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
  userid,
  subscribertype,
  viewid,
  SUM(affiliateClicks) AS affiliateClicks,
  SUM(engagedtime) AS engagedTime
FROM `apple_news_staging`
WHERE ingestionDate >= "2022-10-01"
  AND ingestionDate BETWEEN @apple_news_traffic_start AND @apple_news_traffic_end
GROUP BY ALL;
