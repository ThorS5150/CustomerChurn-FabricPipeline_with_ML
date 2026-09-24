# Power Platform, Fabric & PowerBI Analytics & Data Science Project

**Building an Enterprise-Grade Analytics Platform in Microsoft Fabric**

## Table of Content

1. Project Overview
 - 1.1 Context
 - 1.2 Actions
 - 1.3 Results
 - 1.4 Growth/Next Steps
2. Concept Overview 
3. Data Overview & Preparation
4. Building the pipelines/platform (Application & Code)
 - 4.1 Creating the Worspaces and Deployment Pipeline
 - 4.2 Creating the Fabric items
 - 4.3 Running the Data pipeline
 - 4.4 Buidling Reports in Power BI
5. Ensure Data Governance - ISO 42001  
6. ML Modelling Overview
7. Summary & Analysing the results
8. Skills demonstrated


##  1. Project Overview

In this project, we demonstrate how to create a ...... that combines Fabric with Power Platforms and shows the main concepts of Data Science incl. ISO42001 and Reporting with Power BI

 1.0 Context
  We want a One Platform Solution that integrates our  daily operational work with Power Platfom applications to gain insights out of this data using ML and a automated Reporting Pipeline for the Management to get all important insights as soon as possible by repecting data quality and data governance regulatins and rules   

 1.1 Actions
  We build a Platform that:
  - Loads Data from the Dataverse (Power Platform) into a Bronze Lakehouse
  - Clean data using data wrangling in a notebook (nb_DataWrangling)
  - Validate Data in the bronze layer with Great Expectations before loading data into the silver layer
  - Loading cleaned data from the silver layer to train, test and evaluate ML Model for churn predictions
  - Checks if the model is drifting or discriminating (ISO 42001)
  - If model is drifitng, we train the model automatically new 
  - Load aggregated data into gold layer for reporting reasons
  ....

### 1.3 Results
The final pipeline/platform:
   - automaticly loads an transforms data from daily data out of Dataverse (Power Apps) into a Fabric Lakehouse  
   - automaticlly cleans and validates data from Dataverse in regards to ISO 42001 
   - daily updates the ML model and checks ISO 42001 conformity
   - daily updates all reports and semantic models 

  This helps the management to get aware of any changes in customer churn and helps them to understand what are the reasons customer leave and develop strategies to avoid loosing customers in the future

1.3 More Applications from Power platform or other Ddta sources could be integrated to be loaded into the Lakehouse for data cleaning and preparation. 
    Furthermore ... 



## 2. Concept Overview

### Power Platform/Apps
is

### Fabric 
is

ML Modelling:
We use ....  

MLFlow is ...

#### Fairlearn 
Fairlearn is ..

#### Evidently AI
Evidently is ...




##  3. Data Overview & Preparation

The dataset contains informations about the customers and their churn from a telecom company.
The data is collected on a daily base by the employees how are dealing with the customer day by day.
There are currently 5,000+ customers in the relevant dataset used for analyse the churn behaviour of the clients 

- Fabric Notebook
We use a Fabric notebook to load the data from the bronze lakehouse and do the data wrangling. 

- Powr BI Reports
We build 10+ Dax Measures to mainly aggreagte 
For reporting and analytics a star schema is used with the customer churn as Fact table and 5+ Dim tables (used within the daily business Power Apps application)

## 4. Building the Pipelines (Application & Code)
Here a short overview of which Technology we use for which layer and what the purpose of this t.

### 🛠️ Technology Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Data Source** | Dataverse | Store data  |
| **Connection** | Dataverse  | Secure connectivity |
| **Orchestration** | Fabric Data Factory | Pipeline scheduling |
| **Transformation** | Python Notebooks | ETL at scale |
| **ML Modelling** | Notebook & ML Model | ML Model | 
| **Storage** | Fabric Lakehouse (Delta Lake) | Bronze/Silver/Gold |
| **Analytics DB** | Fabric Data Warehouse | Structured analytics |
| **Semantic Layer** | Fabric Semantic Model | Star schema + DAX |
| **Reporting** | Power BI Desktop/Service | Dashboards & reports |
| **Governance** | Notebook & Fabric Admin Portal | ISO42001 & Security & lineage |


### End-to-end analytics solution combining:
- **a. Deployment Pipeline for Development to Production**
- **b. Full Medallion Lakehouse**: Bronze/Silver/Gold
- **c. Dual-Path Pipleine**: Data Science/ML + BI/Analytics for Reporting Insights 
- **d. Enterprise Security**: Row-Level Security (RLS), Object-Level Security (OLS)
- **e. ISO 42001 - AIMS Compliance**: Check for ISO 42001 Compliance by using Great expecations (DataQuality/-Governance - Annex A.4.3), 
                                                                           MLFlow (Audit Trails - Clause 7.5), 
                                                                           Fairlearn (Fairness - Annex A.5) and   
                                                                           Evidently AI (Model Validation/- Drift - Annex A.7) 





 **a. Deployment Pipeline**

![Screenshot](images/DDI%20Deployment%20Pipeline.png)

1. DEVELOPMENT Workspace
   → Develop Data Factory Pipeline
   → Bronze (raw) → Silver (clean) → Gold (analytics)
   → Transformation Code versioned in Git
   → Semantic Model + Power BI (Dev versions)
   → All debugging & experimentation

2. TESTING Workspace
   → Deploy Data Factory Pipeline
   → Validate Semantic Model relationships
   → Test RLS rules & security
   → Performance testing
   → Approve for Production

3. PRODUCTION Workspace
   → Deploy Data Factory Pipeline
   → Deploy optimized Semantic Model
   → Deploy Power BI Reports/Dashboaords and publish in Power BI Service
   → Activate aggregations
   → Schedule daily refresh (6 AM)

4. TROUBLESHOOTING
   If Production breaks:
   ① Debug in Development 
   ② Fix transformation logic
   ③ Redeploy to Test and Production

### 4.2 Creating the Fabric items

**1. Pipeline**
Use of the Pipeline item to orchestrate a DataFlow

**2. Copy job**
In the settings of the pipeline we set Retry to 3 with a retry intervall of 60 sec. We do this to avoid a failure of the pipeline due to e.g. a temporary connection problem. 

**3. Lakehouse**
with a medallion architecture of:

*Bronze Layer* (Raw Data)
- Direct copies from Dataverse
- 100% data lineage preserved
- No transformations
- Used for debugging & auditing

*Silver Layer* (Cleaned Data)
- Deduplication & null handling
- Business rules applied
- Data quality/ISO 42001 validation gates with Great Expectations
- Conformed dimensions for consistency

*Gold Layer* (Analytics Ready)
- Star schema fact & dimension tables
- Pre-aggregated metrics
- Optimized for Semantic Model


c. Dual Path Pipeline 
![Screenshot](images/DDI DDI Pipeline DataFlow.png)



5. Ensure Security, Data Governance - ISO 42001

### 5. Security & Governance
- **Row-Level Security (RLS)**: Filter by 
- **Object-Level Security (OLS)**: Hide sensitive measures
- **Impact Analysis**: Understand measure dependencies
- **Audit Logging**: Track data access & changes
- **Workspace Roles**: Admin, contributor, viewer permissions
- **Enterprise Security**: Row-Level Security (RLS), Object-Level Security (OLS)
- **ISO 42001 - AIMS Compliance**: Check for ISO 42001 Compliance by using
     - Great expecations (DataQuality/-Governance - Annex A.4.3), 
     - MLFlow (Audit Trails - Clause 7.5), 
     - Fairlearn (Fairness - Annex A.5) and   
     - Evidently AI (Model Validation/- Drift - Annex A.7) 

### 6. ML Modelling Overview

--> You can find the Notbook under notebooks/ML_CustomerChurn-1821.ipynb

1. Load and Data Preparation/Transformation
2. MODELL 1: RandomForest with Hyperparameter-Tuning & Feature Selection
3. MODELL 2: XGBoost with Hyperparameter-Tuning & Feature Selection 
4. Compare Model 1 & 2
5. Use of Fairlearn for Fairness
6. Evidently Report for Drifitng

### 3. Data Science Path (Lakehouse + Python)
- **Lakehouse**: Silver tables in table format
- **Python Notebooks**: DataWrangler, pandas, 
- **Exploratory Analysis**: Ad-hoc data investigation
- **Feature Engineering**: ML-ready datasets | Hyperparameter tuning | Feature Selection
   - Notebook- ML Customer Churn
- **Output**: ML models for production, Evideltly Report 


7. Summary & Analysing the results



### 4. BI/Analytics Path (Semantic Model - Star schema + Power BI)
- **Lakehouse**: Medallion architecture with Gold optimization
- **Semantic Model**: Star schema (1 fact table, 5+ dimensions)
- **DAX Measures**: 10+ calculations
- **Power BI Reports**: Sales, customer, ..




## 🚀 Quick Start (5 Minutes)

### Prerequisites
- Microsoft Fabric workspace (free trial available)
- Power BI Desktop
- Python 3.8+ 
- Great Expectations 1.22.0
- Fairlearn 0.10.0
- Evidently 0.4.25



## 📚 Documentation

- **[SETUP_GUIDE.md](./documentation/SETUP_GUIDE.md)** - Step-by-step implementation
- **[ARCHITECTURE.md](./documentation/ARCHITECTURE.md)** - Architecture decisions
- **[DATA_DICTIONARY.md](./documentation/DATA_DICTIONARY.md)** - Table & column reference
- **[DAX_MEASURES.md](./documentation/DAX_MEASURES.md)** - 50+ measure formulas
- **[QUICK_START.md](./QUICK_START.md)** - 5-minute quick start
- **[GITHUB_PUSH_GUIDE.md](./GITHUB_PUSH_GUIDE.md)** - Push to GitHub

---

## 🎓 7. Skills Demonstrated

✅ **Modern Data Architecture**
- Medallion pattern (Bronze/Silver/Gold)
- Lakehouse design

✅ **Data Engineering**
- Fabric Data Factory pipelines
- Data validation with Great Expectations
- Python data transformation
- Delta Lake operations
- Incremental loading strategies

✅ **Analytics & BI**
- Star schema dimensional modeling
- Advanced DAX (20+ measures)
- Performance optimization

✅ **Security & Governance**
- Row-Level Security (RLS) implementation
- Object-Level Security (OLS)
- Impact analysis & lineage
- Workspace management
- Audit & compliance
- ISO 42001 conformity with MlFlow, Great Expectations, Fairlearn and Evidently

✅ **DevOps & Deployment**
- Multi-workspace strategy (Dev/Test/Prod)
- Controlled code promotion
- Git integration
- Change management
- Monitoring & SLA tracking

✅ **Python & Data Science**
- DataWrangler for exploration
- pandas transformation
- Data visualization with matplotlib and seaborn
- ML-ready feature engineering
- Notebook orchestration





## 📄 License

MIT License - Feel free to fork and adapt.


---

**Last Updated**: 2026-08-12  
**Architecture Strategy**: Gold-Only for Test/Prod (Simplified & Cost-Optimized)  
**Status**: Production Ready
