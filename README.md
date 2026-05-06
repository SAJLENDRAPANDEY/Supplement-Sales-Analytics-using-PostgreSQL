# 📊 Supplement Sales Analytics using PostgreSQL

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Expert-blue?style=flat-square)
![Status](https://img.shields.io/badge/Status-Active-success?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

A comprehensive **PostgreSQL-based analytics project** analyzing supplement sales data (2020–2025) with advanced SQL techniques, window functions, and business intelligence insights. This project demonstrates proficiency in SQL query optimization, data analysis, and extracting actionable business metrics.

---

## 🎯 Project Highlights

- **Dataset**: 2020–2025 supplement sales data from Kaggle with 10+ dimensional attributes
- **Core Analysis**: Revenue trends, product performance, return rate analysis, and discount impact
- **SQL Techniques**: Window functions, CTEs, aggregate queries, date functions, correlation analysis
- **Actionable Insights**: Identified top-performing categories, platforms, and growth opportunities
- **Business Focus**: KPI tracking, month-on-month growth analysis, and customer behavior patterns

---

## 📋 Table of Contents

- [Dataset Overview](#dataset-overview)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [SQL Analysis Breakdown](#sql-analysis-breakdown)
- [Key Findings](#key-findings)
- [Technologies](#technologies)
- [Setup Instructions](#setup-instructions)
- [Future Enhancements](#future-enhancements)
- [Author](#author)

---

## 📊 Dataset Overview

| Feature | Description |
|---------|-------------|
| **Source** | [Kaggle - Supplement Sales Data](https://www.kaggle.com/datasets/zahidmughal2343/supplement-sales-data) |
| **Time Period** | 2020 - 2025 (Weekly Data) |
| **Categories** | Protein, Vitamins, Omega, Amino Acids, etc. |
| **Dimensions** | Date, Product, Category, Location, Platform |
| **Metrics** | Units Sold, Revenue, Discount, Returns, Price |

---

## 📁 Project Structure

```
Supplement-Sales-Analytics/
│
├── dataset/
│   └── Supplement_Sales_Weekly_Expanded.csv
│
├── sql_queries/
│   ├── 01_table_creation.sql          # Schema & table setup
│   ├── 02_basic_analysis.sql          # Aggregations & breakdowns
│   ├── 03_intermediate_analysis.sql   # Trends & return rates
│   ├── 04_advanced_analysis.sql       # Window functions & growth
│   └── 05_business_insights.sql       # KPI & customer analysis
│
├── screenshots/                        # Query results & visualizations
├── dashboard/                         # Power BI dashboard (optional)
├── README.md                          # This file
└── insights.md                        # Detailed findings & recommendations
```

---

## 🚀 Quick Start

### Prerequisites
- PostgreSQL 12+
- CSV dataset from Kaggle

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/SAJLENDRAPANDEY/supplement-sales-analytics.git
   cd supplement-sales-analytics
   ```

2. **Create PostgreSQL database**
   ```sql
   CREATE DATABASE supplement_sales_db;
   ```

3. **Run table creation script**
   ```bash
   psql -U postgres -d supplement_sales_db -f sql_queries/01_table_creation.sql
   ```

4. **Import CSV data**
   ```sql
   COPY supplement_sales FROM '/path/to/Supplement_Sales_Weekly_Expanded.csv' 
   WITH (FORMAT csv, HEADER true, DELIMITER ',');
   ```

5. **Execute analysis scripts** (in order)
   ```bash
   psql -U postgres -d supplement_sales_db -f sql_queries/02_basic_analysis.sql
   psql -U postgres -d supplement_sales_db -f sql_queries/03_intermediate_analysis.sql
   psql -U postgres -d supplement_sales_db -f sql_queries/04_advanced_analysis.sql
   psql -U postgres -d supplement_sales_db -f sql_queries/05_business_insights.sql
   ```

---

## 📈 SQL Analysis Breakdown

### **02_basic_analysis.sql** - Foundation Queries
- Total revenue, orders, and returns overview
- Category-wise revenue breakdown
- Top 5 products & locations by revenue
- Platform performance comparison

### **03_intermediate_analysis.sql** - Trend Analysis
- Yearly revenue trends (2020-2025)
- Monthly revenue patterns
- Return rate analysis by product
- Peak sales day identification
- Discount impact on unit sales

### **04_advanced_analysis.sql** - Advanced Analytics
- **Window Functions**: Running totals, cumulative revenue
- **LAG()**: Month-on-month growth calculation & growth percentage
- **RANK()**: Top 3 products per category
- **Correlation Analysis**: Price vs. demand correlation
- Top growing products (2023 vs 2024)

### **05_business_insights.sql** - KPI Tracking
- Customer return behavior segmentation
- Platform revenue ranking
- Highest-performing locations
- Strategic business metrics

---

## 🎯 Key Findings

### Revenue Insights
✅ **Protein supplements** generated the highest category revenue  
✅ **Revenue growth acceleration** from 2023 to 2024  
✅ **Specific platforms** contributed disproportionately to sales  

### Customer Behavior
✅ **Return rates vary significantly** by product (quality/expectation mismatch)  
✅ **Discount optimization**: Higher discounts positively correlated with unit sales  
✅ **Location patterns**: Certain geographies outperformed others consistently  

### Operational Metrics
✅ **Day-of-week patterns**: Identified peak sales days for inventory planning  
✅ **Price elasticity**: Calculated correlation between pricing and demand by category  
✅ **Growth leaders**: Top 5 products with YoY growth rankings  

---

## 🛠 Technologies

| Technology | Purpose |
|-----------|---------|
| **PostgreSQL** | Relational database & query execution |
| **SQL** | Data analysis & business intelligence |
| **CSV** | Data ingestion & format |
| **Git** | Version control & collaboration |
| **Power BI** | Optional visualization & dashboarding |

---

## 📚 SQL Concepts Demonstrated

```
✓ Aggregate Functions (SUM, AVG, COUNT, CORR)
✓ GROUP BY & HAVING clauses
✓ Window Functions (SUM OVER, LAG, RANK, PARTITION BY)
✓ Common Table Expressions (CTEs)
✓ Subqueries & nested queries
✓ Date Functions (EXTRACT, DATE_TRUNC, TO_CHAR)
✓ CASE WHEN conditional logic
✓ JOIN operations (if applicable)
✓ ORDER BY & LIMIT clauses
✓ Correlation & statistical analysis
```

---

## 🚀 Future Enhancements

- [ ] **Power BI Dashboard**: Interactive visualizations & drill-down capabilities
- [ ] **Forecasting**: Time-series forecasting for Q1 2026 revenue
- [ ] **Stored Procedures**: Automated monthly report generation
- [ ] **Query Optimization**: Index strategy for large-scale datasets
- [ ] **Views & Materialized Views**: Pre-computed aggregations for performance
- [ ] **Advanced Segments**: Cohort analysis & customer lifetime value (CLV)

---

## 📊 Sample Query Results

### Top 5 Products by Revenue
```
product_name         | total_revenue
---------------------|---------------
Whey Protein Powder  | $2,450,000
Vitamin D3 Capsules  | $1,890,000
Omega-3 Fish Oil     | $1,760,000
BCAA Powder          | $1,540,000
Multivitamin Tablets | $1,420,000
```

### Month-on-Month Growth Trend
```
month        | revenue    | previous_month | growth_percentage
-------------|------------|----------------|------------------
2024-09      | 185,000    | 172,000        | 7.56%
2024-10      | 198,000    | 185,000        | 7.03%
2024-11      | 215,000    | 198,000        | 8.59%
2024-12      | 248,000    | 215,000        | 15.35%
```

---

## 📖 How to Use This Repository

1. **For Learning**: Study the SQL scripts to understand advanced PostgreSQL concepts
2. **For Projects**: Adapt queries for your own sales/analytics datasets
3. **For Interviews**: Showcase this project as evidence of SQL & analytics expertise
4. **For Portfolio**: Include screenshots of results and insights in your resume

---

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

---

## 👨‍💻 Author

**Sajlendra Pandey**  
*Data Analyst & Open Source Contributor*

- **GitHub**: [@SAJLENDRAPANDEY](https://github.com/SAJLENDRAPANDEY)
- **LinkedIn**: [sajlendra-pandey-37378627b](https://www.linkedin.com/in/sajlendra-pandey-37378627b/)
- **Portfolio**: [sajlendrapandey.netlify.app](https://sajlendrapandey.netlify.app)

---

## 🤝 Contributing

Contributions are welcome! Feel free to fork, modify, and submit pull requests with:
- Additional SQL insights
- Query optimizations
- Bug fixes
- Documentation improvements

---

## ⭐ If This Project Helped You

Please consider giving it a **star** ⭐ on GitHub. It motivates me to create more such projects!

---

**Last Updated**: May 2026  
**Dataset Version**: 2020-2025 Weekly Data
