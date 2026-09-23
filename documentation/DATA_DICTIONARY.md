# Data Dictionary - Complete Table Reference

## Fact Tables

### FactInternetSales
**Grain**: One row per product per order line  
**Volume**: 60,000+ rows  
**Update**: Daily incremental

| Column | Type | Description |
|--------|------|-------------|
| SalesOrderNumber | STRING | Order ID |
| SalesOrderLineNumber | INT | Line item number |
| OrderDateKey | INT | Date key (YYYYMMDD) |
| CustomerKey | INT | FK to DimCustomer |
| ProductKey | INT | FK to DimProduct |
| SalesTerritoryKey | INT | FK to DimSalesTerritory |
| PromotionKey | INT | FK to DimPromotion |
| OrderQuantity | INT | Units sold |
| UnitPrice | DECIMAL | Price per unit |
| SalesAmount | DECIMAL | Revenue |
| TotalProductCost | DECIMAL | COGS |
| TaxAmt | DECIMAL | Sales tax |
| Freight | DECIMAL | Shipping |
| OrderDate | DATE | Order date |

### FactReturns
**Grain**: One row per returned product  
**Volume**: 5,000+ rows

| Column | Type |
|--------|------|
| ReturnOrderNumber | STRING |
| ReturnDate | DATE |
| ProductKey | INT |
| CustomerKey | INT |
| ReturnQuantity | INT |
| ReturnAmount | DECIMAL |

## Dimension Tables

### DimDate (Time Dimension)
**Rows**: 4,383 (10+ years)

| Column | Description |
|--------|-------------|
| DateKey | YYYYMMDD format |
| FullDate | Actual date |
| CalendarYear | Year (2010+) |
| CalendarQuarter | Quarter (1-4) |
| MonthNumberOfYear | Month (1-12) |
| WeekNumberOfYear | Week (1-53) |
| IsHoliday | Holiday flag |
| IsWeekend | Weekend flag |

### DimProduct (Product Master)
**Rows**: 500

| Column | Description |
|--------|-------------|
| ProductKey | Surrogate key |
| EnglishProductName | Product name |
| ProductCategoryKey | FK to category |
| ProductSubcategoryKey | FK to subcategory |
| Color | Product color |
| Size | Product size |
| Weight | Product weight |
| StandardCost | Cost |
| ListPrice | MSRP |
| StartDate | Catalog start |
| EndDate | Catalog end (NULL = active) |

**Hierarchy**: Category → Subcategory → Product

### DimCustomer (Customer Master)
**Rows**: 18,000+

| Column | Description |
|--------|-------------|
| CustomerKey | Surrogate key |
| FirstName, LastName | Name |
| EmailAddress | Email |
| City, StateProvinceCode | Location |
| PostalCode, CountryCode | Address |
| BirthDate | DOB |
| YearlyIncome | Annual income |
| TotalChildren | Total children |
| MaritalStatus | M/S |
| HouseOwnerFlag | Home owner (1=Yes) |
| DateFirstPurchase | First order |
| CustomerSegment | RFM segment |

### DimSalesTerritory (Geography)
**Rows**: 11

| Column | Description |
|--------|-------------|
| SalesTerritoryKey | Territory ID |
| SalesTerritoryRegion | Region name |
| SalesTerritoryCountry | Country |
| SalesTerritoryGroup | Geographic group |

**Territories**:
- North America (Northeast, Northwest, Southwest, Southeast, Central)
- Europe (United Kingdom, France, Germany)
- Pacific (Australia)

### DimPromotion (Campaigns)
**Rows**: 12

| Column | Description |
|--------|-------------|
| PromotionKey | Promo ID |
| PromotionName | Campaign name |
| PromotionType | Type (Discontinued Sale, Reseller, Marketing) |
| DiscountPct | Discount % |
| StartDate, EndDate | Campaign dates |

## Key Metrics

### Volumes
- **Transactions**: 60,000+ rows in FactInternetSales
- **Customers**: 18,000+ unique customers
- **Products**: 500 products across categories
- **Date Range**: 10+ years of history

### Quality
- No NULL values in foreign keys
- Dates validated (1900-2099 range)
- Relationships enforced
- Standard costs > 0
- Email addresses unique (per customer)

## Calculated Columns (in Model)

**In FactInternetSales**
```dax
Profit = [SalesAmount] - [TotalProductCost]
Profit Margin % = DIVIDE([Profit], [SalesAmount], 0)
Revenue per Unit = DIVIDE([SalesAmount], [OrderQuantity], 0)
```

**In DimCustomer**
```dax
Full Name = [FirstName] & " " & [LastName]
Age = DATEDIF([BirthDate], TODAY(), YEAR)
Income Band = IF([YearlyIncome] >= 100000, "High", "Medium")
```

## Relationships & Cardinality

All relationships are **1:M** (one-to-many):
- DimProduct → FactInternetSales: 1:Many
- DimCustomer → FactInternetSales: 1:Many
- DimDate → FactInternetSales: 1:Many
- DimSalesTerritory → FactInternetSales: 1:Many
- DimPromotion → FactInternetSales: 1:Many

**Cross Filter**: Single direction (Dim → Fact)

## Data Freshness

- **SQL Server**: Real-time
- **Lakehouse**: Incremental (daily at 2 AM)
- **Semantic Model**: Auto-refresh (hourly)
- **Power BI**: Scheduled or on-demand

---

**Dictionary Version**: 1.0  
**Last Updated**: 2026-08-12
