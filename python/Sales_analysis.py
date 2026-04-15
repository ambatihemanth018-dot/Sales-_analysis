
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(r"C:\Datasets\Amazon_Sales.csv")

# ------------------ Data Cleaning ------------------------

# Convert date
df['OrderDate'] = pd.to_datetime(df['OrderDate'], format='%d-%m-%Y')

# Convert numeric columns
cols = ['Quantity', 'UnitPrice', 'Discount', 'Tax', 'ShippingCost', 'TotalAmount']
df[cols] = df[cols].apply(pd.to_numeric, errors='coerce')

# Handle missing values
df['Brand'] = df['Brand'].fillna('Unknown')

# Drop invalid rows
df = df.dropna(subset=['TotalAmount', 'CustomerID'])

# Remove duplicates
df = df.drop_duplicates()

# ------------------ Data Overview ------------------------

df.info()

print("\nPreview:")
print(df.head())

print("\nMissing Values:")
print(df.isnull().sum())

# ------------------ Revenue analysis ------------------------

print("\n--- Revenue Analysis ---")

# Total Revenue

total_revenue = df['TotalAmount'].sum()
print("Total Revenue:", total_revenue)

print("\nInsight: The dataset generates significant revenue, forming the basis for further business analysis.")

# Revenue by category
rev_category = df.groupby('Category')['TotalAmount'].sum().sort_values(ascending=False)
print(rev_category.head(10))
print("\nInsight: A few categories contribute significantly to total revenue, indicating category concentration.")

# Revenue by brand
rev_brand = df.groupby('Brand')['TotalAmount'].sum().sort_values(ascending=False)
print("\nTop 10 Brands by Revenue:")
print(rev_brand.head(10))
print("\nInsight: Revenue is concentrated among a few brands, indicating key brand dominance.")

# ------------------ Customer analysis ------------------------

# Total customers
print("Total Customers:", df['CustomerID'].nunique())

# Top customers
top_customers = df.groupby('CustomerID')['TotalAmount'].sum().sort_values(ascending=False).head(10)
print("\nTop 10 Customers by Revenue:")
print(top_customers)

# Orders per customer
orders_per_customer = df.groupby('CustomerID')['OrderID'].nunique()
print(orders_per_customer.describe())

print("\nInsight: Most customers place very few orders, indicating low engagement.")

# ------------------ Product analysis ------------------------

# Top products
top_products = df.groupby('ProductName')['TotalAmount'].sum().sort_values(ascending=False).head(10)
print("\nTop 10 Products by Revenue:")
print(top_products)

# ------------------ Time based analysis ------------------------

df['Month'] = df['OrderDate'].dt.to_period('M')
monthly_sales = df.groupby('Month')['TotalAmount'].sum()
print(monthly_sales)

df['Date'] = df['OrderDate'].dt.date
daily_orders = df.groupby('Date')['OrderID'].count()
print(daily_orders)

# ------------------ Payment Method analysis ------------------------

payment_method = df['PaymentMethod'].value_counts()
print(payment_method)

print("\nInsight: Certain payment methods are more popular among customers.")

# ------------------ Order status analysis --------------------------

order_status = df['OrderStatus'].value_counts()
print(order_status)

print("\nInsight: Some orders are cancelled or returned, indicating potential operational issues.")

# ------------------ Visualization ----------------------------------

# Revenue by category

rev_category.head(10).plot(kind='bar')
plt.title("Top Categories by Revenue")
print("\nInsight: A few categories contribute the majority of revenue, indicating strong dependency on high-performing categories.")
plt.show()

# Monthly sales

monthly_sales.plot()
plt.title("Monthly Revenue Trend")
print("\nInsight: Revenue fluctuates over time, indicating seasonal demand patterns and varying customer activity.")
plt.show()

# Top products

top_products.plot(kind='bar')
plt.title("Top Products by Revenue")
print("\nInsight: A few products generate most of the revenue, highlighting key revenue drivers.")
plt.show()

# Top customers

top_customers.plot(kind='bar')
plt.title("Top Customers")
print("\nInsight: A small group of customers contributes a significant portion of total revenue, indicating high-value customers.")
plt.show()

# Orders distribution

orders_per_customer.plot(kind='hist', bins=30)
plt.title("Orders per Customer Distribution")
print("\nInsight: Most customers place very few orders, indicating low engagement and retention challenges.")
plt.show()