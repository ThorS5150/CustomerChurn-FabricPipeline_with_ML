# Setup Guide: Fabric PowerBI AdventureWorks Analytics

Complete step-by-step guide to set up the analytics solution from scratch.

## Prerequisites

### Required Software
- **SQL Server 2022** with AdventureWorksDW2022 database
- **Microsoft Fabric** workspace (Free Trial: https://app.fabric.microsoft.com)
- **Power BI Desktop** (latest version)
- **Python 3.8+** (optional)

### Required Access
- SQL Server read access to AdventureWorksDW2022
- Microsoft Fabric workspace creator permissions
- Power BI Pro or Premium capacity

## Step 1: Database Setup

### 1.1 Install AdventureWorksDW2022

Download from Microsoft: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure

```sql
USE AdventureWorksDW2022;

-- Verify installation
SELECT COUNT(*) as FactSalesCount FROM dbo.FactInternetSales;
SELECT COUNT(*) as DimProductCount FROM dbo.DimProduct;
SELECT COUNT(*) as DimCustomerCount FROM dbo.DimCustomer;
```

## Step 2: Fabric Workspace Setup

1. Go to https://app.fabric.microsoft.com
2. Create workspace: `PowerBI-AdventureWorks`
3. Create Lakehouse: `adventureworks_lakehouse`
4. Create Semantic Model: `AdventureWorks_SemanticModel`

## Step 3: Data Ingestion

In Lakehouse:
1. Click "New Table" → "Get data from SQL Server"
2. Server: `localhost` | Database: `AdventureWorksDW2022`
3. Select tables:
   - `FactInternetSales`, `FactReturns`
   - `DimDate`, `DimProduct`, `DimCustomer`, `DimSalesTerritory`, `DimPromotion`
4. Configure refresh: Daily at 2:00 AM (off-peak)

## Step 4: Build Semantic Model

### Star Schema Structure
```
FactInternetSales
├── DimProduct (ProductKey)
├── DimCustomer (CustomerKey)
├── DimDate (OrderDateKey)
├── DimSalesTerritory (SalesTerritoryKey)
└── DimPromotion (PromotionKey)
```

### Key DAX Measures
```dax
Total Revenue = SUM(FactInternetSales[SalesAmount])
Total Orders = COUNTA(FactInternetSales[SalesOrderNumber])
Avg Order Value = DIVIDE([Total Revenue], [Total Orders], 0)
YTD Revenue = CALCULATE([Total Revenue], DATESYTD(DimDate[DateKey]))
Revenue Growth % = DIVIDE([Total Revenue] - CALCULATE([Total Revenue], DATEADD(DimDate[DateKey], -1, YEAR)), CALCULATE([Total Revenue], DATEADD(DimDate[DateKey], -1, YEAR)), 0)
```

## Step 5: Power BI Reports

1. Open Power BI Desktop
2. Get Data → Fabric → Select semantic model
3. Create dashboards:
   - Sales Overview (KPIs, trends, territories)
   - Product Analysis (top products, categories)
   - Customer Insights (RFM segmentation, LTV)
4. Publish to Fabric workspace

## Step 6: Row-Level Security (RLS)

```dax
[SalesTerritoryKey] = USERNAME()
```

## Verification Checklist

- [ ] Database restored
- [ ] Lakehouse created with all tables
- [ ] Semantic model with relationships built
- [ ] DAX measures created
- [ ] Power BI reports connected
- [ ] Refresh schedule configured
- [ ] RLS tested

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Can't connect to SQL Server | Verify credentials, check firewall |
| Data not loading | Check Fabric refresh logs |
| Reports empty | Refresh data (Ctrl+R), verify relationships |
| Performance slow | Check DAX Studio, enable aggregations |

---

For detailed instructions, see full documentation in repository.
