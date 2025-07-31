<h1>Apple News Engagement and Monetization Pipeline</h1>

<h2>🧠 Project Overview</h2>
This project simulates a full-stack data pipeline for aggregating and analyzing user engagement, ad revenue, and ecommerce activity from a content platform (modeled on Apple News). Built using SQL for BigQuery with modular transformation layers, it is designed to be scalable, modular, and ready for dashboarding.
<br />

<h2>🎯 Objectives</h2>
- Provide high-level visibility into Apple News content performance<br />
- Enable combined analysis of Apple News, ecom, and ads datasets<br />
- Support editorial decision-making for content optimization, updates, and customization<br />


<h2>🔧 What I Built</h2>
- Created staging and production tables in the data warehouse for Apple News content<br />
- Joins user behavior with ecommerce and advertising revenue data<br />
- Applies incremental loading and historical comparisons (1, 2, 4, and 52 weeks ago)<br />
- Built a final daily summary table for Looker production (BI dashboard integration)<br />

<h2>🧠 Key Metrics Tracked</h2>

⦁	Users (total, subscribed, non-subscribed)<br />
⦁	Page views and unique views<br />
⦁	Total engaged time<br />
⦁	Affiliate link clicks<br />
⦁	Ecommerce revenue (USD/GBP, order values, transactions)<br />
⦁	Ad impressions and revenue (daily & monthly, USD/GBP)<br />
⦁	Historical benchmarks (1, 2, 4, 52 weeks ago)<br />


<h2>📈 Business Impact</h2>
 ✅ Centralizes multiple monetization sources (ads + affiliate revenue)<br />
 ✅ Enables content teams to assess brand performance over time<br />
 ✅ Provides finance with currency-adjusted revenue figures<br />
	✅ Reduces manual reporting work with automation and comparison logic<br />
	✅ Supports decision-making on paywalled vs. sponsored content<br />
	✅ Aligns audience engagement metrics with ecommerce ROI<br />


<h2>🛠 Tools & Stack</h2>
⦁	SQL (BigQuery)<br />
⦁	Dataform / SQLX-style transformations<br />
⦁	Partitioning, clustering, and incremental loads<br />

## Process Walk-Through:
- [Staging Table](https://github.com/zarasash/DataPipeline/blob/main/apple_news_staging_pipeline.sql)
- [Production Table Query](https://github.com/zarasash/DataPipeline/blob/main/apple_news_prod_table.sql)
- [Base Data Preparation](https://github.com/zarasash/DataPipeline/blob/main/apple_news_combined_base_table.sql)
- [Looker Table for Daily Comparisons](https://github.com/zarasash/DataPipeline/blob/main/apple_news_daily_table_for_looker.sql)
<p align="center">

<h2>📝 Disclaimer</h2>
This project is a sanitized version of a real-world enterprise pipeline. All datasets and references have been anonymized and generalized for portfolio sharing.
<br />


<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>


