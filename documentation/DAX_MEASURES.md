# DAX Measures - Complete Reference

5+ DAX measures for analytics and reporting.

## Customer Metrics

1. AvgTenureCustomerChurned = 
CALCULATE(
    AVERAGE('silver CustomerChurn'[cr8b0_tenuremonths]),
    'silver CustomerChurn'[cr8b0_churnstatus] = TRUE()
)

2. Churn Rate % = 
VAR ChurnedCustomers = 
CALCULATE(
    COUNTROWS('silver CustomerChurn'),
    'silver CustomerChurn'[cr8b0_churnstatus] = TRUE()
)
VAR TotalCustomers = COUNTROWS('silver CustomerChurn')

RETURN 
DIVIDE(
    ChurnedCustomers, 
    TotalCustomers
)

3. Hazard Rate = 
VAR m = MAX('silver CustomerChurn'[cr8b0_tenuremonths])
VAR AtRisk = 
    CALCULATE(
        COUNTROWS('silver CustomerChurn'),
        ALL('silver CustomerChurn'[cr8b0_tenuremonths]),
        'silver CustomerChurn'[cr8b0_tenuremonths] >= m
    )
VAR Churns = 
    CALCULATE(
        COUNTROWS('silver CustomerChurn'),
        ALL('silver CustomerChurn'[cr8b0_tenuremonths]),
        'silver CustomerChurn'[cr8b0_tenuremonths] = m,
        'silver CustomerChurn'[cr8b0_churnstatus] = TRUE()
    )
RETURN IF(AtRisk >= 30, DIVIDE(Churns, AtRisk))

4. Retention Rate (KM) = 
VAR tMax = MAX('silver CustomerChurn'[cr8b0_tenuremonths])
VAR t = tMax - 1
VAR AtRiskAtT = 
    CALCULATE(
        COUNTROWS('silver CustomerChurn'),
        ALL('silver CustomerChurn'[cr8b0_tenuremonths]),
        'silver CustomerChurn'[cr8b0_tenuremonths] >= tMax
    )
VAR Months = 
    FILTER(
        ALL('silver CustomerChurn'[cr8b0_tenuremonths]),
        'silver CustomerChurn'[cr8b0_tenuremonths] <= t
    )
RETURN
IF(
    NOT ISBLANK(tMax) && AtRiskAtT >= 36,
    PRODUCTX(
        Months,
        VAR m = 'silver CustomerChurn'[cr8b0_tenuremonths]
        VAR AtRisk = 
            CALCULATE(
                COUNTROWS('silver CustomerChurn'),
                ALL('silver CustomerChurn'[cr8b0_tenuremonths]),
                'silver CustomerChurn'[cr8b0_tenuremonths] >= m
            )
        VAR Churns = 
            CALCULATE(
                COUNTROWS('silver CustomerChurn'),
                ALL('silver CustomerChurn'[cr8b0_tenuremonths]),
                'silver CustomerChurn'[cr8b0_tenuremonths] = m,
                'silver CustomerChurn'[cr8b0_churnstatus] = TRUE()
            )
        RETURN 1 - DIVIDE(Churns, AtRisk, 0)
    )
)

5. Saved Revenue (Scenario) = 
VAR MtMChurnRevenue =
    CALCULATE(
        SUM('silver CustomerChurn'[cr8b0_monthlycharges]),
        ContractType[ContractType] = "Month-to-month",
        'silver CustomerChurn'[cr8b0_churnstatus] = TRUE()
    )
VAR ChurnRateMtM = CALCULATE([Churn Rate %], ContractType[ContractType] = "Month-to-month") -- Churn Rate Month-to-month
VAR ChurnRate2Y = CALCULATE([Churn Rate %], ContractType[ContractType] = "2 year") -- Churn Rate 2-Jahres-Vertrag
RETURN
    MtMChurnRevenue * MtM_CustomerChurn_Reduction * DIVIDE((ChurnRateMtM - ChurnRate2Y)*'Transition efficiency'[Transition efficiency Value], ChurnRateMtM)*12