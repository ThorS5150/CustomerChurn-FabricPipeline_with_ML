# DAX Measures - Complete Reference

40+ DAX formulas for analytics and reporting.

## Revenue & Sales

```dax
Total Revenue = SUM(FactInternetSales[SalesAmount])
Total Orders = COUNTA(FactInternetSales[SalesOrderNumber])
Total Transactions = COUNTROWS(FactInternetSales)
Average Order Value = DIVIDE([Total Revenue], [Total Orders], 0)
Total Quantity Sold = SUM(FactInternetSales[OrderQuantity])
```

## Profitability

```dax
Total Cost = SUM(FactInternetSales[TotalProductCost])
Total Profit = [Total Revenue] - [Total Cost]
Profit Margin % = DIVIDE([Total Profit], [Total Revenue], 0)
Gross Profit = [Total Revenue] - [Total Cost]
```

## Customer Metrics

```dax
Total Customers = DISTINCTCOUNT(FactInternetSales[CustomerKey])
Revenue Per Customer = DIVIDE([Total Revenue], [Total Customers], 0)
Avg Transaction Value = DIVIDE([Total Revenue], COUNTROWS(FactInternetSales), 0)
```

## Time Intelligence

```dax
YTD Revenue = CALCULATE([Total Revenue], DATESYTD(DimDate[DateKey]))
MTD Revenue = CALCULATE([Total Revenue], DATESMTD(DimDate[DateKey]))
Prior Year Revenue = CALCULATE([Total Revenue], DATEADD(DimDate[DateKey], -1, YEAR))

Revenue Growth YoY = [Total Revenue] - [Prior Year Revenue]
Revenue Growth % YoY = DIVIDE([Revenue Growth YoY], [Prior Year Revenue], 0)

Prior Quarter Revenue = CALCULATE([Total Revenue], DATEADD(DimDate[DateKey], -1, QUARTER))
Revenue Growth QoQ % = DIVIDE([Total Revenue] - [Prior Quarter Revenue], [Prior Quarter Revenue], 0)
```

## Rankings & Filters

```dax
Product Rank = RANKX(ALL(DimProduct), [Total Revenue],, DESC)
Is Top 10 = IF([Product Rank] <= 10, 1, 0)

Revenue Running Total = CALCULATE([Total Revenue], 
    FILTER(ALL(DimDate[DateKey]), DimDate[DateKey] <= MAX(DimDate[DateKey])))
```

## Forecasting

```dax
Avg Monthly Revenue = CALCULATE([Total Revenue], ALL(DimDate)) / 
    DISTINCTCOUNT(DimDate[MonthKey])

Forecast Revenue 3M MA = AVERAGE(FILTER(ALL(DimDate),
    DimDate[DateKey] >= MAX(DimDate[DateKey]) - 90
    && DimDate[DateKey] <= MAX(DimDate[DateKey]))[Total Revenue])
```

## Customer Analysis

```dax
Customer Frequency = COUNTROWS(FILTER(VALUES(FactInternetSales[SalesOrderNumber]),
    FactInternetSales[CustomerKey] = MAX(FactInternetSales[CustomerKey])))

Customer Monetary = CALCULATE([Total Revenue], 
    VALUES(FactInternetSales[CustomerKey]))

Days Since Last Purchase = DATEDIF(MAX(FactInternetSales[OrderDate]), TODAY(), DAY)
```

## Territory & Geography

```dax
Territory Revenue Share = DIVIDE([Total Revenue],
    CALCULATE([Total Revenue], ALL(DimSalesTerritory)))

Territory Customers = DISTINCTCOUNT(FactInternetSales[CustomerKey])

Revenue per Territory = DIVIDE([Total Revenue],
    DISTINCTCOUNT(DimSalesTerritory[SalesTerritoryKey]), 0)
```

## Key Measure Patterns

### Year-over-Year Comparison
```dax
Measure YoY = 
VAR CurrentYear = [Total Revenue]
VAR PriorYear = [Prior Year Revenue]
RETURN DIVIDE(CurrentYear - PriorYear, PriorYear)
```

### Conditional Aggregation
```dax
High Value Sales = CALCULATE([Total Revenue],
    FILTER(FactInternetSales, FactInternetSales[SalesAmount] > 500))
```

### Parametric Filtering
```dax
Filtered Revenue = CALCULATE([Total Revenue],
    FILTER(ALL(DimProduct), DimProduct[Color] = SELECTEDVALUE(Colors[SelectedColor])))
```

## Best Practices

✅ Always use DIVIDE() for safety  
✅ Use clear, descriptive names  
✅ Set appropriate formatting (currency, %)  
✅ Profile with DAX Studio  
✅ Document complex calculations  
✅ Optimize filter context  

---

**Total Measures**: 40+  
**Implementation Time**: 8-16 hours  
**Complexity Level**: Intermediate to Advanced
