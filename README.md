 Project Title

Smart City Urban Mobility & Public Transport Analytics

 Project Overview

This project demonstrates an end-to-end Data Engineering pipeline built using the Medallion Architecture (Bronze → Silver → Gold) to analyze urban mobility patterns and public transport performance in a smart city context.

The pipeline ingests large-scale raw data from Google Sheets, processes and validates it using Python and SQL, and exposes business-ready datasets for dashboarding and decision-making.

 Business Problems Addressed
1. Urban Mobility & Environmental Impact

Which city zones experience the highest private travel demand?

How does public transport usage relate to congestion and air quality?

2. Public Transport Route Reliability

Which bus routes experience higher delays?

How reliable are bus services across routes?

Which routes require operational improvement?

 Architecture (Medallion Pattern)

Bronze Layer

Raw datasets generated in Google Sheets using Apps Script

CSV exports ingested into PostgreSQL

No transformations applied

Silver Layer

Data cleaning and standardization

Timestamp parsing and delay calculation

Separate Silver representations created to support different analytical grains

Gold Layer

Business-ready aggregated tables

Zone-level city mobility metrics

Route-level public transport reliability metrics

 Tech Stack

Data Source: Google Sheets + Apps Script

ETL & Automation: Python

Database: PostgreSQL

Transformations: SQL

Dashboard: Google Looker Studio

Version Control: GitHub

📊 Gold Tables
1. gold.city_dashboard_facts

Provides zone-level daily metrics:

Private vehicle trips

Average trip distance

Bus passenger volume

Average bus delay

Air quality index (AQI)

2. gold.bus_service_reliability_facts

Provides route-level operational metrics:

Total bus trips

Average delay

On-time performance (%)

Average occupancy

 How to Run the Pipeline
python3 src/etl.py


This command:

Loads Bronze data

Builds Silver transformations

Creates Gold tables

The pipeline is idempotent and safe to rerun.

 Dashboard

The dashboard connects directly to Gold outputs and presents:

City mobility overview

Public transport efficiency

Environmental impact

Route-level reliability analysis

 Key Learnings

Medallion Architecture enables scalable and reusable analytics

Multiple Gold datasets can be created from the same raw data to answer different business questions

Clear storytelling is more important than complex visuals

 Conclusion

This project demonstrates practical data engineering skills including data ingestion, transformation, automation, and analytics delivery using real-world design patterns.


## Automation
The ETL pipeline is automated using cron jobs.
Schedule: Daily execution.
Logs are stored in /logs/etl.log.
