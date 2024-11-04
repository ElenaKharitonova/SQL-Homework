/*Ранжируйте продукты (по ProductRank) в каждой категории на основе их общего объема продаж (TotalSales).*/

SELECT
RANK() OVER (ORDER BY SUM(Quantity * Price)
DESC) AS ProductRank,
p.ProductName,
SUM(Quantity * Price) AS TotalSales
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID;

/*Обратимся к таблице Clusters Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого кластера и месяца, учитывая общую среднюю сумму
кредита за соответствующий месяц (OverallAvgCreditAmount). Определите OverallAvgCreditAmount в первой строке результатов запроса.*/

-- Рассчитываем среднюю сумму кредита для каждого кластера и месяца
WITH AvgCredit AS (
SELECT
month,
cluster,
AVG(credit_amount) AS AvgCreditAmount
FROM Clusters
GROUP BY month, cluster
),
-- Рассчитываем общую среднюю сумму кредита за соответствующий месяц
SumCredit AS (
SELECT
month,
SUM(credit_amount) AS OverallAvgCreditAmount
FROM Clusters
GROUP BY month
)
-- Объединяем результаты
SELECT
a.month,
a.cluster,
a.AvgCreditAmount,
m.OverallAvgCreditAmount
FROM AvgCredit a
JOIN SumCredit m ON a.month = m.month

/*Ответ: 
month	cluster	  AvgCreditAmount	OverallAvgCreditAmount 
1			0	18000.0				3641000
1			2	39500.0				3641000
1			3	22114.864864864863	3641000
1			4	33714.28571428572	3641000
2			0	22452.380952380954	4165000
2			2	74750.0				4165000
2			3	25530.303030303032	4165000
2			4	31337.20930232558	4165000
2			5	190500.0			4165000
2			6	57166.666666666664	4165000
3			0	26607.14285714286	4494000
3			2	82100.0				4494000
3			3	21768.817204301075	4494000
3			4	37071.42857142857	4494000
3			5	39000.0				4494000
3			6	30166.666666666668	4494000
...........................................
...........................................*/

/*Определите OverallAvgCreditAmount в первой строке результатов запроса.*/

WITH AvgCredit AS (
SELECT
month,
cluster,
AVG(credit_amount) AS AvgCreditAmount
FROM Clusters
GROUP BY month, cluster
),

SumCredit AS (
SELECT
month,
SUM(credit_amount) AS OverallAvgCreditAmount
FROM Clusters
GROUP BY month
)

SELECT
a.month,
a.cluster,
m.OverallAvgCreditAmount
FROM AvgCredit a
JOIN SumCredit m ON a.month = m.month
LIMIT 1;

/*Ответ^  
 * month	cluster	  OverallAvgCreditAmount
 * 1	      0  	     3641000*/

/*Сопоставьте совокупную сумму сумм кредита (CumulativeSum) для каждого кластера, упорядоченную по месяцам, и сумму кредита в порядке возрастания.*/

SELECT 
    cluster, 
    month, 
    credit_amount, 
    SUM(credit_amount) OVER (PARTITION BY cluster ORDER BY month ASC) AS CumulativeSum
FROM Clusters
ORDER BY credit_amount, CumulativeSum, cluster, month

/*Ответ: 
cluster month credit_amount ComulativeSum
3		1		5000		1636500
0		8		5000		2897000
3		2		5000		3321500
0		11		5000		4434500
3		3		5000		5346000
3		4		5000		7209500
3		4		5000		7209500
3		4		5000		7209500
3		5		5000		8679000
...................................
*/


/*Определите CumulativeSum в первой строке результатов запроса*/

SELECT    
    SUM(credit_amount) OVER (PARTITION BY cluster ORDER BY month ASC) AS CumulativeSum
FROM Clusters
ORDER BY credit_amount, CumulativeSum, cluster, MONTH
LIMIT 1

/*Ответ: 1 636 500*/




