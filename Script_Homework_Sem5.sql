/*Создайте хранимую процедуру с именем «GetEmployeeOrders». который принимает идентификатор сотрудника в качестве параметра и возвращает все заказы, обработанные этим
сотрудником.
Пропишите запрос, который создаст требуемую процедуру.*/

CREATE PROCEDURE GetEmployeeOrders
@pEmployeeID INT
AS
BEGIN
	SELECT 
	OrderID, EmployeeID
	FROM Orders o 
	WHERE EmployeeID = @pEmployeeID
	ORDER BY OrderID DESC
END;

/*вызываем процедуру GetEmployeeOrders, передаем параметр @pEmployeeID = 6 */
EXECUTE GetEmployeeOrders @pEmployeeID = 6

/*Ответ:  
OrderID EmployeeID
10439		6
10425		6
10423		6
10395		6
10390		6
10370		6
10356		6
10355		6
10350		6
10317		6
10298		6
10296		6
10291		6
10274		6
10272		6
10271		6
10264		6
10249		6
 */

/* Создайте таблицу EmployeeRoles, как на уроке и удалите ее. Напишите запрос, который удалит нужную таблицу.*/

/*удаление таблицы перед созданием, если с таким именем уже есть*/
DROP TABLE IF EXISTS EmployeeRoles; 
CREATE TABLE EmployeeRoles (
EmployeeID INT PRIMARY KEY,
OrderID INT,
Photo VARCHAR(10)
);

/*--удаление таблицы, если такая есть*/
DROP TABLE IF EXISTS EmployeeRoles; 

/* Удалите все заказы со статусом 'Delivered' из таблицы OrderStatus, которую создавали на семинаре Напишите запрос, который удалит нужные строки в таблице.*/

DELETE FROM OrderStatus WHERE Status = 'Delivered'