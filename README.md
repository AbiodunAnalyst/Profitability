## Analyzing E-commerce Profitability
#### Introduction
In the rapidly evolving e-commerce landscape, businesses must continuously adapt to ensure profitability across various sales channels. This case study delves into an in-depth dataset that provides valuable insights into e-commerce profitability, examining the performance across multiple platforms like Shiprocket and INCREFF, and detailing financial metrics such as expenses and profits. The data also covers SKU-level details, MRPs across different stores, and transactional parameters that collectively offer a granular view of sales dynamics.

#### Objective
The primary objective of this case study is to demonstrate how businesses can leverage a detailed e-commerce dataset to uncover insights into profitability across different sales channels. By analyzing this dataset, companies can identify key factors driving profits and losses, optimize pricing strategies, and make data-driven decisions to enhance overall performance.

#### Dataset Overview
The dataset used in this analysis includes the following key components:

**Sales Channels**: The dataset provides data from various sales channels, including Shiprocket and INCREFF.
**SKU and Product Details**: Includes SKU codes, design numbers, stock levels, product categories, sizes, and colors.
**Market Retail Prices (MRPs)**: Contains MRPs across multiple stores, such as Ajio, Amazon (including FBA), Flipkart, Limeroad, Myntra, and Paytm.
**Customer and Transaction Data**: Tracks the amount paid by customers, rate per piece, date of sale, transaction status, quantity sold, and currency.
**Financial Metrics**: Includes gross amount, related expenses, and calculated profits.

#### Business Question
1. Impact of Fulfillment Method on Sales by Region:
      ##### Variables Involved: 
        1.  Fulfilment, 
        2.  ship-state, 
        3.  Amount, 
        4.  Qty
        5.  Month

2. Cancellation Rate by Product Category and Fulfillment Method:
      ##### Variables Involved: 
        1.  Status, 
        2.  Category, 
        3.  Fulfilment, 
        4.  Qty
        5.  Month

3. Sales Channel and Promotion Impact on Revenue by Product Category:
      ##### Variables Involved: 
        1.  Sales Channel, 
        2.  promotion-ids, 
        3.  Category, 
        4.  Amount
        5.  Month


4. B2B vs. B2C Sales Performance by Category and Region:
      ##### Variables Involved: 
            1.  B2B, 
            2.  Category, 
            3.  ship-state, 
            4.  Amount, 
            5.  Qty
            6.  Month


5. Order Volume and Revenue by Product Size, Category, and Fulfillment:
      ##### Variables Involved: 
        1.  Size, 
        2.  Category, 
        3.  Fulfilment, 
        4.  Qty, 
        5.  Amount
        6.  Month


####      Methodology
**Data Cleaning**: The data cleaning process will be done using R-Studio with R-Language to check for missing value, empty space, quality check, transformation and overall build a transfoemation pipeline. Transformation code is attached in Profitability.R

**Storage**: The data will be loaded into PostgreSQL after the transformation is completed and further data structure will take place to structure the data based on each business question. Query Code for forming each materialview is attached to TABLE_QUERY

**Analysis of Data**: This will be done using POWER BI


#### RESULT







