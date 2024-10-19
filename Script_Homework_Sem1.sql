--В каких странах проживают наши клиенты (таблица Customers)?
SELECT Country FROM Customers;

--Сколько уникальных стран вы получили в ответе?
SELECT COUNT(DISTINCT Country) FROM Customers;
--ответ 21

--Сколько клиентов проживает в Argentina?
SELECT COUNT(*) FROM Customers 
WHERE Country = "Argentina";
--ответ 3

--Посчитайте среднюю цену и количество товаров в 8 категории (таблица Products ).
SELECT AVG(Price) AS avg_price,
       COUNT(ProductName) AS total_products FROM Products 
WHERE CategoryID = 8;

--или

SELECT AVG(Price) AS avg_price,
       COUNT(*) AS total_products FROM Products 
WHERE CategoryID = 8;
--20.6825 ср. цена, 12 товаров

--Найдите количество товаров в 8 категории
SELECT COUNT(*) AS total_products FROM Products 
WHERE CategoryID = 8;
--12

--Посчитайте средний возраст работников (таблица Employees)
SELECT CAST(AVG((JULIANDAY('2024-01-01') - JULIANDAY(BirthDate)) / 365) AS INTEGER) 
AS avg_age FROM Employees;
--66

--Вам необходимо получить заказы, которые сделаны в течении 35 дней до даты 2023-10-10 (то есть с 5
--сентября до 10 октября включительно). Использовать функцию DATEDIFF, определить переменные для
--даты и диапазона. 
--Определите CustomerID, который оказался в первой строке запроса.
--Функция DATEDIFF в SQLite не работает, используем функцию BETWEEN
SELECT * FROM Orders
WHERE OrderDate BETWEEN '2023-09-05' AND '2024-10-10'
ORDER BY OrderDate
LIMIT(1);
--37

--Вам необходимо получить количество заказов за сентябрь месяц (тремя способами, через LIKE, с
--помощью YEAR и MONTH и сравнение начальной и конечной даты).
--Первый способ
SELECT COUNT(*) AS september_orders FROM Orders
WHERE OrderDate LIKE '2023-09%';
--23
--Второй способ (функции YEAR и Month SQLite не поддерживает, используем функцию STRFTIME)
SELECT COUNT(*) AS september_orders FROM Orders 
WHERE STRFTIME('%Y', orderdate) = '2023' 
AND STRFTIME('%m', orderdate) = '09';
--23
--Третий способ
SELECT COUNT(*) AS september_orders FROM Orders
WHERE OrderDate >= '2023-09-01' AND OrderDate <= '2023-09-30';
--23