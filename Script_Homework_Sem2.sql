/*ЗАДАНИЕ 1 Вам необходимо проверить влияние семейного положения (family_status) на средний доход клиентов (income) и запрашиваемый кредит (credit_amount) .*/

SELECT family_status, ROUND(AVG(income),2) AS avg_income, credit_amount
--COUNT(*) AS cnt,
FROM Clusters
GROUP BY family_status
ORDER BY family_status;

/*
 *family_status             avg_income                credit_amount
 *Another                   32 756,04                  7 000
 *Married                   32 272,52                 14 500
 *Unmarried                 33 217,95                 10 000
 */
/*Вывод: Средний доход не особенно зависит от семейного статуса. Но более высокие кредиты запрашивают клиенты женатые/замужем



/*ЗАДАНИЕ 2. Сколько товаров в категории Meat/Poultry.*/

SELECT COUNT(productName) AS cnt FROM Products
WHERE CategoryID IN
(SELECT CategoryID FROM Categories
WHERE CategoryName = 'Meat/Poultry');
/*Ответ: 6  */


/*Какой товар (название) заказывали в сумме в самом большом количестве (sum(Quantity) в таблице OrderDetails)*/


SELECT productName FROM Products
WHERE ProductID IN (
SELECT ProductID
FROM OrderDetails
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC
LIMIT(1));


/*Ответ: Gorgonzola Telino*/


