use blinkit;

-- Cleaning the data like column name is not correct way 
-- Rename Columns Name

ALTER TABLE Blinkit
  CHANGE COLUMN `Item Fat Content` `Item_Fat_Content` VARCHAR(50),
  CHANGE COLUMN `Item Identifier` `Item_Identifier` VARCHAR(50),
  CHANGE COLUMN `Item Type` `Item_Type` VARCHAR(100),
  CHANGE COLUMN `Outlet Establishment Year2` `Outlet_Establishment_Year` INT,
  CHANGE COLUMN `Outlet Identifier` `Outlet_Identifier` VARCHAR(50),
  CHANGE COLUMN `Outlet Location Type` `Outlet_Location_Type` VARCHAR(50),
  CHANGE COLUMN `Outlet Size` `Outlet_Size` VARCHAR(50),
  CHANGE COLUMN `Outlet Type` `Outlet_Type` VARCHAR(50),
  CHANGE COLUMN `Item Visibility` `Item_Visibility` FLOAT,
  CHANGE COLUMN `Item Weight` `Item_Weight` FLOAT,
  CHANGE COLUMN `Total Sales` `Total_Sales` FLOAT,
  CHANGE COLUMN `Rating` `Rating` FLOAT;




SELECT `Item Weight` FROM Blinkit 
WHERE `Item Weight` = '' 
   OR `Item Weight` IS NULL 
   OR `Item Weight` NOT REGEXP '^[0-9.]+$';
   
   
-- If there are empty strings (""), convert them to NULL:   

UPDATE Blinkit 
SET `Item Weight` = NULL 
WHERE `Item Weight` = '';




---


### **Option 1: Disable Safe Mode Temporarily**
-- 1. **Run this command** to disable safe mode:
  
SET SQL_SAFE_UPDATES = 0;
 
-- 2. **Now run your update query**:
 
   UPDATE Blinkit 
   SET `Item Weight` = NULL 
   WHERE `Item Weight` = '';

-- 3. **Re-enable safe mode (recommended for safety)**:

SET SQL_SAFE_UPDATES = 1;
   

---





-- now i am just doing Update the data because data incorrect 
select * from blinkit;

## •	DATA CLEANING:
Cleaning the Item_Fat_Content field ensures data consistency and accuracy in analysis. The presence of multiple variations of the same category 
(e.g., LF, low fat vs. Low Fat) can cause issues in reporting, aggregations, and filtering. By standardizing these values, 
we improve data quality, making it easier to generate insights and maintain uniformity in our datasets.


UPDATE blinkit  
SET `Item Fat Content` =  
    CASE  
        WHEN `Item Fat Content` IN ('LF', 'low fat') THEN 'Low Fat'  
        WHEN `Item Fat Content` = 'reg' THEN 'Regular'  
        ELSE `Item Fat Content`  
    END  
WHERE `Item Fat Content` IN ('LF', 'low fat', 'reg');

SET SQL_SAFE_UPDATES = 1;


-- After executing this query check the data has been cleaned or not using below query
	
SELECT DISTINCT Item_Fat_Content FROM blinkit;








-- A. KPI’s
-- 1. TOTAL SALES:
SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit;

-- 2. AVERAGE SALES

SELECT avg(Total_Sales) AS Total_Sales FROM blinkit;

SELECT CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales
FROM blinkit;





-- 3. NO OF ITEMS

SELECT count(*)  AS no_of_items
FROM blinkit;




-- 4. A - AVG RATING

SELECT CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Sales
FROM blinkit;


-- B. Total Sales by Fat Content:

SELECT 
   Item_Fat_Content,
    CAST(SUM(Total_Sales) AS DECIMAL (10 , 2 )) AS Total_Sales
FROM
    blinkit
GROUP BY Item_Fat_Content;



-- C. Total Sales by Item Type
SELECT Item_type, cast(sum(Total_Sales) as decimal (10,2)) AS Total_Sales  
FROM blinkit  
GROUP BY Item_type
order by Total_Sales desc;






-- D. Fat Content by Outlet for Total Sales

SELECT Item_Fat_Content, Outlet_Identifier, SUM(Total_Sales) AS Total_Sales  
FROM blinkit  
GROUP BY Item_Fat_Content, Outlet_Identifier  
ORDER BY Item_Fat_Content, Outlet_Identifier;

-- D-  "Total Sales by Outlet Location Type, categorized by Fat Content (Low Fat & Regular)"  OR "Comparison of Total Sales for Low Fat and Regular Items across Outlet Location Types"

SELECT Outlet_Location_Type,  
       SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END) AS Low_Fat,  
       SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END) AS Regular  
FROM blinkit  
GROUP BY Outlet_Location_Type  
ORDER BY Outlet_Location_Type;



-- Selecting `Outlet_Location_Type`**
-- Retrieves the **location type** (e.g., Tier 1, Tier 2, Tier 3) for each outlet.  

#### Using `SUM(CASE WHEN ...)` for Conditional Aggregation**
--  **First `SUM(CASE WHEN ...)` Statement:**  
 
-- SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` ELSE 0 END) AS Low_Fat
 
-- Checks if `Item Fat Content` is **'Low Fat'**.  
-- If **true**, it adds `Total Sales` to the **Low_Fat** column.  
-- If **false**, it adds **0** (ensuring only relevant sales are summed).  

--  **Second `SUM(CASE WHEN ...)` Statement:**  

-- SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` ELSE 0 END) AS Regular
 
  - Works similarly but sums sales for **'Regular'** items.  

#### `GROUP BY Outlet_Location_Type`**
-- Groups the results **by location type** (Tier 1, Tier 2, Tier 3).  
-- Ensures that sales are aggregated per location type.  

#### `ORDER BY Outlet_Location_Type`**
--  Sorts the final result based on `Outlet_Location_Type` in ascending order.  








-- E. Total Sales by Outlet Establishment

select * from blinkit;

SELECT 
    outlet_establishment_year,
    SUM(total_sales) AS total_sales
FROM
    blinkit
GROUP BY outlet_establishment_year
ORDER BY total_sales DESC;



-- F. Percentage of Sales by Outlet Size

SELECT Outlet_Size,  
       cast(SUM(Total_Sales) as decimal(10,2)) AS Total_Sales,  
       cast((SUM(Total_Sales) / (SELECT  SUM(Total_Sales) FROM blinkit) * 100) as decimal(10,2)) AS Sales_Percentage  
FROM blinkit  
GROUP BY Outlet_Size  
ORDER BY Sales_Percentage DESC;




-- G. Sales by Outlet Location

select * from blinkit;

SELECT outlet_location_type, cast(sum(Total_Sales) as decimal (10,2)) AS Total_Sales  
FROM blinkit  
GROUP BY outlet_location_type
order by Total_Sales desc;



-- H. All Metrics by Outlet Type:

SELECT outlet_location_type, 
cast(sum(Total_Sales) as decimal (10,2)) AS Total_Sales,
CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Sales,
cast(SUM(Total_Sales) as decimal(10,2)) AS Total_Sales,  
cast((SUM(Total_Sales) / (SELECT  SUM(Total_Sales) FROM blinkit) * 100) as decimal(10,2)) AS Sales_Percentage 
FROM blinkit  
GROUP BY outlet_location_type
order by Total_Sales desc;

















 