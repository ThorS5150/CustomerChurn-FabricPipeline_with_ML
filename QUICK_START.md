# Quick Start Guide (5 Minutes)

Get the analytics project running in 5 minutes.

## Prerequisites Checklist
- ✅ SQL Server 2022 with AdventureWorksDW2022 installed
- ✅ Microsoft Fabric account (free trial: https://app.fabric.microsoft.com)
- ✅ Power BI Desktop installed

## 5-Minute Setup

### 1. Clone Repository (30 seconds)
```bash
git clone https://github.com/ThorS5150/fabric-powerbi-adventureworks.git
cd fabric-powerbi-adventureworks
```

### 2. Verify Database (1 minute)
```sql
USE AdventureWorksDW2022;
SELECT COUNT(*) as SalesRecords FROM FactInternetSales;
```
Expected: 60,000+ rows ✅

### 3. Create Fabric Workspace (2 minutes)
1. Go to https://app.fabric.microsoft.com
2. Create workspace: `PowerBI-AdventureWorks`
3. Create Lakehouse: `adventureworks_lakehouse`

### 4. Connect & Load Data (1 minute)
1. In Lakehouse: "Get data from SQL Server"
2. Server: `localhost` | Database: `AdventureWorksDW2022`
3. Select: `FactInternetSales`, `DimProduct`, `DimCustomer`, `DimDate`, `DimSalesTerritory`
4. Click Load

### 5. Open Reports (30 seconds)
1. Download `.pbix` from `/reports`
2. Open in Power BI Desktop
3. Refresh data → Done! 🎉

## Next Steps

- 📚 [SETUP_GUIDE.md](./documentation/SETUP_GUIDE.md) - Detailed setup
- 📊 [ARCHITECTURE.md](./documentation/ARCHITECTURE.md) - Data model
- 🔍 [setup.sql](./data/sql/setup.sql) - SQL queries

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Can't connect to SQL Server | Test with `sqlcmd -S localhost -U sa` |
| Data not loading | Check Fabric refresh logs & credentials |
| Reports show no data | Refresh (Ctrl+R), check relationships |

---

**Time to first insight**: ~5 minutes ⚡
