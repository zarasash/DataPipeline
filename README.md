<h1>Creating DataPipeline</h1>



<h2>🧠 Project Overview</h2>
This project involved building a new data pipeline to support cross-functional insights across Apple News, e-commerce (ecom), and advertising (ads) data sources. The goal was to empower the editorial team with data-driven guidance for optimizing and customizing Apple News content.
<br />

<h2>🎯 Objectives</h2>
- Provide high-level visibility into Apple News content performance<br />
- Enable combined analysis of Apple News, ecom, and ads datasets<br />
- Support editorial decision-making for content optimization, updates, and customization<br />

<h2>🔧 What I Built</h2>
- Created staging and production tables in the data warehouse for Apple News content<br />
- Combined Apple News data with: E-commerce tables (Clicks, Revenue) & Ads tables (Impressions, clicks, Revenue)<br />
- Built a final daily summary table for Looker production (BI dashboard integration)<br />

<h2>📈 Business Impact</h2>
- This pipeline allows editors and content strategists to:<br />
- See which Brand drive product interest or revenue<br />
- Understand how ad performance correlates with Brand<br />
- Make better-informed decisions about what to feature, promote, or retire<br />

<h2>🛠 Tools & Stack</h2>
- Data Warehouse : BigQuery <br />
- SQL (ETL logic for staging & prod tables)<br />
- Looker (daily reporting/dashboard layer)<br />

## Process Walk-Through:
- [Staging Table](https://github.com/zarasash/DataPipeline/blob/main/apple_news_staging_pipeline.sql)
- [Production Table Query](https://github.com/zarasash/DataPipeline/blob/main/apple_news_prod_table.sql)
- [Base Data Preparation](https://github.com/zarasash/DataPipeline/blob/main/apple_news_combined_base_table.sql)
- [Looker Table for Daily Comparisons](https://github.com/zarasash/DataPipeline/blob/main/apple_news_daily_table_for_looker.sql)
<p align="center">

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


