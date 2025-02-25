# Blinkit_MYSQL_Project

 

---

# **BlinkIT Data Analysis Dashboard 🚀**  

## 📌 **Project Overview**  
This project presents a **comprehensive data analysis** of BlinkIT's grocery sales using **MySQL and Power BI**. It focuses on **sales performance, customer satisfaction, and inventory distribution** to derive meaningful business insights.  

The analysis includes:  
✔ **SQL Queries for Data Extraction & Transformation**  
✔ **Power BI Dashboard for Data Visualization**  

---

## 📊 **Key Performance Indicators (KPIs)**  
The dashboard focuses on the following primary KPIs:  

- **Total Sales:** Overall revenue generated from all items sold (**$1.20M**)  
- **Average Sales:** Average revenue per sale (**$141**)  
- **Number of Items:** Total count of different items sold (**8523**)  
- **Average Rating:** Average customer rating for items sold (**3.9 out of 5**)  

---

## 🔍 **SQL Data Analysis**  

### **1️⃣ Sales Performance by Outlet Type**  
```sql
SELECT Outlet_Type, SUM(Total_Sales) AS Total_Revenue, 
       AVG(Total_Sales) AS Avg_Sales
FROM BlinkIT_Grocery 
GROUP BY Outlet_Type 
ORDER BY Total_Revenue DESC;
```
💡 **Insight:** Supermarkets generate the highest sales, while grocery stores have better item visibility.  

---

### **2️⃣ Fat Content Analysis (Low Fat vs. Regular Sales by Location)**  
```sql
SELECT Outlet_Location_Type,  
       SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` ELSE 0 END) AS Low_Fat_Sales,  
       SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` ELSE 0 END) AS Regular_Sales  
FROM BlinkIT_Grocery  
GROUP BY Outlet_Location_Type  
ORDER BY Outlet_Location_Type;
```
💡 **Insight:** Consumer preference leans towards **low-fat products**, suggesting a shift towards health-conscious buying habits.  

---

### **3️⃣ Top-Selling Product Categories**  
```sql
SELECT Item_Type, SUM(Total_Sales) AS Total_Category_Sales
FROM BlinkIT_Grocery
GROUP BY Item_Type
ORDER BY Total_Category_Sales DESC
LIMIT 5;
```
💡 **Insight:** **Fruits, vegetables, and snack foods** are the top-selling categories.  

---

### **4️⃣ Outlet Profitability Analysis (Size & Location Impact on Sales)**  
```sql
SELECT Outlet_Size, Outlet_Location_Type, 
       SUM(Total_Sales) AS Total_Sales
FROM BlinkIT_Grocery
GROUP BY Outlet_Size, Outlet_Location_Type
ORDER BY Total_Sales DESC;
```
💡 **Insight:** **Medium-sized outlets in Tier 3 locations** are the most profitable.  

---

### **5️⃣ Outlet Growth Trend (Establishment Over Time)**  
```sql
SELECT Outlet_Establishment_Year, COUNT(*) AS Number_of_Outlets
FROM BlinkIT_Grocery
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;
```
💡 **Insight:** The number of outlets has grown significantly **from 2012 to 2022**, indicating business expansion.  

---

## 📊 **Power BI Dashboard Features**  
🔹 **Filter Panel:** Allows users to filter data by **outlet location type, outlet size, and item type**  
🔹 **Outlet Establishment Trend:** Shows **growth of outlets from 2012 to 2022**  
🔹 **Fat Content Analysis:** Breaks down sales for **low-fat vs. regular-fat products**  
🔹 **Item Type Distribution:** Sales distribution across **various product categories**  
🔹 **Outlet Size & Location Analysis:** Performance comparison by **outlet size and location tier**  
🔹 **Outlet Type Comparison:** Compares different outlet types based on **sales, number of items, average sales, ratings, and item visibility**  

---

## 🎯 **Insights & Business Impact**  
✅ **$1M+ Total Sales:** Strong overall sales performance  
✅ **Health-Conscious Buying:** **Higher demand for low-fat products**  
✅ **Top-Selling Categories:** Fruits, vegetables, and snack foods lead in sales  
✅ **Best Performing Outlets:** **Medium-sized outlets in Tier 3 locations** show the highest profitability  
✅ **Supermarket vs. Grocery Stores:** Supermarkets generate **higher sales**, while grocery stores have **better item visibility**  

---

## 📂 **Technologies Used**  
- **SQL (MySQL)** – Data extraction, transformation, and analysis  
- **Power BI** – Interactive dashboard and data visualization  
- **Data Cleaning & Preprocessing** – Handling missing values and data standardization  

---

## ⚠️ **Note:**  
This project is conducted **for educational purposes** and is based on sample data.  
