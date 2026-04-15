
# 📊 Amazon Sales Data Analysis

## 📌 Project Overview

This project analyzes Amazon sales data to uncover key business insights related to revenue, customer behavior, product performance, and sales trends.
The analysis is performed using **Python (Pandas, Matplotlib)** and focuses on transforming raw data into actionable insights.

---

## 🛠 Tools & Technologies

* Python
* Pandas
* Matplotlib

---

## 📂 Dataset Features

The dataset includes the following key columns:

* OrderID, OrderDate
* CustomerID, CustomerName
* ProductID, ProductName
* Category, Brand
* Quantity, UnitPrice, Discount
* Tax, ShippingCost, TotalAmount
* PaymentMethod, OrderStatus
* City, State, Country

---

## 🔄 Project Workflow

### 1. Data Cleaning

* Converted `OrderDate` to datetime format
* Converted numerical columns (price, tax, etc.)
* Handled missing values in `Brand`
* Removed invalid and duplicate records

---

### 2. Data Overview

* Checked dataset structure using `.info()`
* Previewed data using `.head()`
* Identified missing values

---

### 3. Revenue Analysis

* Total revenue calculation
* Revenue by category
* Revenue by brand

📌 **Insight:**
A small number of categories and brands contribute the majority of revenue, indicating strong business concentration.

---

### 4. Customer Analysis

* Total number of customers
* Top 10 customers by revenue
* Order frequency per customer

📌 **Insight:**
A small group of customers contributes significantly to total revenue, while most customers show low engagement.

---

### 5. Product Analysis

* Top 10 products by revenue

📌 **Insight:**
A few products generate most of the sales, highlighting key revenue drivers.

---

### 6. Time-Based Analysis

* Monthly revenue trends
* Daily order trends

📌 **Insight:**
Revenue fluctuates over time, indicating seasonal demand and changing customer activity.

---

### 7. Payment Method Analysis

* Distribution of payment methods

📌 **Insight:**
Certain payment methods are more popular among customers, indicating preference patterns.

---

### 8. Order Status Analysis

* Distribution of order statuses

📌 **Insight:**
Some orders are cancelled or returned, indicating potential operational or service issues.

---

## 📊 Visualizations

### 🔹 Top Categories by Revenue

![Top Categories](images/category_revenue.png)

➡️ Few categories dominate revenue contribution.

---

### 🔹 Monthly Revenue Trend

![Monthly Sales](images/monthly_sales.png)

➡️ Revenue shows fluctuations indicating seasonal patterns.

---

### 🔹 Top Products by Revenue

![Top Products](images/top_products.png)

➡️ A small number of products drive most of the revenue.

---

### 🔹 Top Customers

![Top Customers](images/top_customers.png)

➡️ High-value customers contribute significantly to total sales.

---

### 🔹 Orders per Customer Distribution

![Orders Distribution](images/orders_distribution.png)

➡️ Most customers have low purchase frequency.

---

## 📁 Project Structure

```
Amazon-Sales-Analysis/
│
├── data/
├── python/
│   └── analysis.py           
├── images/
├── README.md
```

---

## 🚀 Key Business Insights

* Revenue is highly concentrated among top categories and brands
* A small group of customers contributes the majority of revenue
* Most customers are low-engagement users
* Sales show time-based fluctuations (seasonality)
* Certain products act as major revenue drivers

---

## 🎯 Conclusion

This project demonstrates how data analysis can be used to identify revenue drivers, customer behavior patterns, and business opportunities.
The insights can help in improving marketing strategies, customer retention, and inventory planning.

---

## 📌 Future Improvements

* Add predictive analysis (sales forecasting)
* Build interactive dashboard using Power BI
* Perform customer segmentation

---
