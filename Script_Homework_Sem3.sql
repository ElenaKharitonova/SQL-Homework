/*Посчитать средний чек одного заказа.*/

SELECT 
    ROUND(AVG(Total_Order),2) AS Average_Check
FROM (
    SELECT 
        SUM(Quantity * Price) AS Total_Order
    FROM OrderDetails AS od
    JOIN Products AS p ON od.ProductID = p.ProductID 
    GROUP BY OrderID);
   
/*Ответ: 1 971,55  */   

/*Посчитать сколько заказов доставляет в месяц каждая служба доставки.*/

SELECT
    s.ShipperName AS Shipper,
    strftime('%m', o.OrderDate) AS Month,
    strftime('%Y', o.OrderDate) AS Year,
    COUNT(o.OrderID) AS OrderCount
FROM Orders AS o
JOIN Shippers AS s ON o.ShipperID = s.ShipperID
GROUP BY s.ShipperName, strftime('%Y', o.OrderDate), strftime('%m', o.OrderDate);
ORDER BY s.ShipperName DESC, YEAR DESC, MONTH DESC

/*strftime('%Y', o.OrderDate) — извлекает год из даты в формате YYYY.
strftime('%m', o.OrderDate) — извлекает месяц из даты в формате MM.*/

/*Ответ: 
Shipper           Month     Year    OrderCount  
Federal Shipping	07	    2023	   9
Federal Shipping	08	    2023	   8
Federal Shipping	09	    2023       5
Federal Shipping	10	    2023	  10
Federal Shipping	11	    2023	  10
Federal Shipping	12	    2023	  16
Federal Shipping	01	    2024	   8
Federal Shipping	02	    2024	   2
Speedy_Express	    07	    2023	   7
Speedy_Express	    08		2023	   9
Speedy_Express	    09		2023	   3
Speedy_Express	    10		2023	   6
Speedy_Express	    11		2023	   6
Speedy_Express	    12		2023	   7
Speedy_Express	    01		2024	  14
Speedy_Express	    02		2024	   2
United Package	    07		2023	   6
United Package	    08		2023	   8
United Package	    09		2023	  15
United Package	    10		2023	  10
United Package	    11		2023	   9
United Package	    12		2023	   8
United Package	    01		2024	  11
United Package	    02		2024	   7
*/

/*Определите, сколько заказов доставила United Package в декабре 2023 года*/

SELECT Shipper, MONTH, YEAR, OrderCount 

FROM (
	SELECT
    	s.ShipperName AS Shipper,
    	strftime('%m', o.OrderDate) AS Month,
    	strftime('%Y', o.OrderDate) AS Year,
    COUNT(o.OrderID) AS OrderCount
FROM Orders AS o
JOIN Shippers AS s ON o.ShipperID = s.ShipperID
GROUP BY s.ShipperName, strftime('%Y', o.OrderDate), strftime('%m', o.OrderDate)
ORDER BY s.ShipperName DESC, YEAR DESC, MONTH DESC)

WHERE Year = '2023' AND Month = '12' AND  Shipper = 'United Package';

/*Ответ:  Shipper           Month    Year    OrderCount
 *        UnitedPackage     12       2023    8
 */

/* Определить средний LTV покупателя (сколько денег покупатели в среднем тратят в магазине за весь период)*/

SELECT 
    ROUND(AVG(Customer_Total),2) AS Average_expenses
FROM (
    SELECT 
        SUM(Quantity * Price) AS Customer_Total
    FROM OrderDetails AS od
    JOIN Products AS p ON od.ProductID = p.ProductID
    JOIN Orders AS o ON od.OrderID = o.OrderID
    GROUP BY CustomerID);
   
   /*Ответ: 5 221,95 */
