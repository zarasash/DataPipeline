-- Anonymized Data Pipeline for Public Sharing
-- This code is a generalized and anonymized version of a data processing pipeline.
-- It is designed to demonstrate a data transformation process without
-- revealing specific business logic, data sources, or sensitive information.
-- The concepts and techniques used are common in data warehousing and analytics.

WITH transformed_data AS (
  SELECT
    DATE(event_timestamp) AS event_date,
    DATE(processing_timestamp) AS processing_date,
    entity_id AS entity,
    IFNULL(location, '') AS region,
    IFNULL(device_type, '') AS device_category,
    IFNULL(source_of_traffic, '') AS traffic_source,
    content_id AS unique_content_id,
    IFNULL(content_url, '') AS content_url,
    IFNULL(content_title, '') AS content_title,
    content_type AS content_category,
    IFNULL(is_sponsored, FALSE) AS is_sponsored,
    IFNULL(is_promotional, FALSE) AS is_promotional,
    IFNULL(is_subscription_required, FALSE) AS is_gated,
    IFNULL(is_multimedia, FALSE) AS is_multimedia,
    IFNULL(has_video, FALSE) AS has_video,
    user_id AS user_identifier,
    user_segment AS user_segment,
    session_id AS session_identifier,
    engagement_duration AS engagement_duration,
    event_type AS event_type,
    ARRAY_LENGTH(interaction_events) AS interaction_clicks,
    ROW_NUMBER() OVER (
      PARTITION BY
        entity_id, location, device_type, source_of_traffic, session_id, user_id, content_id, content_title, content_type, content_url,
        is_sponsored, is_promotional, is_gated, is_multimedia, has_video, user_segment, event_timestamp
      ORDER BY processing_timestamp DESC
    ) AS row_number
  FROM `data_source_table`,
  UNNEST(events) AS event_data
  WHERE
    event_type = "CONTENT_VIEW_EVENT"
    AND DATE(processing_timestamp) BETWEEN @pipeline_start_date AND @pipeline_end_date
)

SELECT
  event_date,
  processing_date,
  entity,
  region,
  device_category,
  traffic_source,
  unique_content_id,
  content_url,
  content_category,
  content_title,
  is_sponsored,
  is_promotional,
  is_gated,
  is_multimedia,
  has_video,
  user_identifier,
  user_segment,
  session_identifier,
  SUM(interaction_clicks) AS interaction_clicks,
  SUM(engagement_duration) AS total_engagement_duration
FROM transformed_data
WHERE row_number = 1
GROUP BY ALL;
