# Simple PostgreSQL Data Analysis

This project demonstrates basic data analysis using PostgreSQL with a sample sales database.

## Overview

The analysis includes:
- Customer data
- Product catalog
- Sales transactions
- 8 analytical queries for business insights

## Database Schema

### Tables:
1. **customers** - Customer information (name, email, city, signup date)
2. **products** - Product catalog (name, category, price)
3. **sales** - Transaction records (customer, product, quantity, date, amount)

## Setup Instructions

### 1. Install PostgreSQL
Make sure PostgreSQL is installed on your system.

### 2. Run the Script
```bash
# Connect to PostgreSQL
psql -U your_username

# Create and use the database
CREATE DATABASE sales_db;
\c sales_db

# Run the analysis script
\i sales_analysis.sql
```

Or run it directly:
```bash
psql -U your_username -d sales_db -f sales_analysis.sql
```

## Analysis Queries Included

### 1. Revenue by Product Category
Shows total sales, quantity, and revenue for each product category.

### 2. Top 5 Customers
Identifies the highest-spending customers.

### 3. Monthly Sales Trend
Tracks revenue and order patterns over time.

### 4. Best Selling Products
Lists products by units sold and revenue generated.

### 5. Sales by City
Geographic analysis of sales performance.

### 6. Customer Purchase Frequency
Analyzes customer behavior and lifetime value.

### 7. Product Category Performance
Statistical summary of product pricing by category.

### 8. Revenue Per Customer by City
Calculates average customer value in each location.

## Sample Insights

After running the queries, you'll be able to answer questions like:
- Which product category generates the most revenue?
- Who are our most valuable customers?
- What's the sales trend over recent months?
- Which cities have the highest customer value?
- What products are bestsellers?

## Customization

You can modify the script to:
- Add more sample data
- Create additional analysis queries
- Add indexes for performance
- Include more complex JOIN operations
- Add date range filters
- Create views for commonly used queries

## Requirements

- PostgreSQL 12 or higher
- Basic SQL knowledge
- Command line or pgAdmin access

## Next Steps

1. Run the script to create the database and tables
2. Execute the analysis queries one by one
3. Modify queries to explore different aspects of the data
4. Add your own data or queries for practice

## Notes

- All monetary values are in USD
- Sample data covers January-April 2024
- The database uses SERIAL for auto-incrementing IDs
- Foreign key constraints maintain referential integrity
