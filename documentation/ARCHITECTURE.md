# Architecture - Fabric PowerBI AdventureWorks

## Data Architecture

```
SQL Server (AdventureWorksDW2022) 
       ↓
   Fabric Lakehouse
       ↓
  Semantic Model (Star Schema)
       ↓
Power BI Dashboards
```

## Star Schema Design

### Fact Table: FactInternetSales
- **Grain**: One row per product per order line
- **Volume**: 60,000+ transactions
- **Measures**: SalesAmount, OrderQuantity, TotalProductCost, TaxAmt

### Dimension Tables
| Table | Rows | Purpose |
|-------|------|---------|
| DimDate | 4,383 | Time-based analysis (10+ years) |
| DimProduct | 500 | Product categorization |
| DimCustomer | 18,000+ | Customer segmentation |
| DimSalesTerritory | 11 | Geographic analysis |
| DimPromotion | 12 | Campaign tracking |

### Relationships (Star Schema)
```
FactInternetSales
├── DimProduct (ProductKey) 1:M
├── DimCustomer (CustomerKey) 1:M
├── DimDate (OrderDateKey) 1:M
├── DimSalesTerritory (SalesTerritoryKey) 1:M
└── DimPromotion (PromotionKey) 1:M
```

## Data Flow

1. **SQL Server** → Raw data (AdventureWorksDW2022)
2. **Lakehouse** → Incremental load (daily) + Full load (monthly)
3. **Semantic Model** → Star schema with relationships
4. **Power BI** → Reports and dashboards

## Optimization Strategies

### 1. Incremental Refresh
- Load last 7 days daily
- Retain 2 years historical
- Monthly full refresh (off-peak)

### 2. Aggregations
- Daily aggregates for fast drill-through
- Pre-calculated for common queries
- Reduces query processing time 10-100x

### 3. Row-Level Security (RLS)
```dax
[SalesTerritoryKey] = USERNAME()
```
Maps users to territories for data isolation.

### 4. Query Performance
- DAX Studio profiling
- Optimized relationships
- Column hiding (hide keys, internal IDs)
- Data type optimization

## Key Features Demonstrated

✅ **Dimensional Modeling** - Kimball star schema  
✅ **Fact & Dimension Design** - Proper grain and conformed dims  
✅ **SCD Type 1 & 2** - Handling dimension changes  
✅ **Incremental Loading** - Delta detection & merge  
✅ **Query Optimization** - Performance tuning  
✅ **Row-Level Security** - Multi-tenant ready  
✅ **Complex DAX** - 50+ measures with time intelligence  

## Performance Targets

- Dashboard load: < 2 seconds
- Query response: < 500ms (P95)
- Model size: ~150 MB (optimized)
- Refresh time: < 10 minutes (incremental)

## Technology Stack

- **Database**: SQL Server 2022 (AdventureWorksDW2022)
- **Data Platform**: Microsoft Fabric (Lakehouse)
- **Semantic Modeling**: Fabric Semantic Model
- **BI Tool**: Power BI Desktop
- **Languages**: T-SQL, DAX, Python (optional)

---

**Architecture Version**: 1.0  
**Status**: Production-Ready
