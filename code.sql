CREATE TABLE t (
	Customer_Name VARCHAR(32),
	Order_Total INT
)Engine=INNODB;

INSERT INTO t (Customer_Name,Order_Total) VALUES("Micheal",1000);
INSERT INTO t (Customer_Name,Order_Total) VALUES("Jonathon",50);
INSERT INTO t (Customer_Name,Order_Total) VALUES("Micheal",1034);
INSERT INTO t (Customer_Name,Order_Total) VALUES("Jonathon",60);
INSERT INTO t (Customer_Name,Order_Total) VALUES("Micheal",345);
INSERT INTO t (Customer_Name,Order_Total) VALUES("Jonathon",530);

SELECT Customer_Name, SUM(Order_Total) AS 'Total Paid' 
FROM t 
GROUP BY Customer_Name;

/*using having clause and group by statement*/

SELECT Customer_Name, SUM(Order_Total) AS 'Total Paid'
FROM t
GROUP BY Customer_Name
HAVING SUM(Order_Total) > 0;

/*illustrating the use of avg() aggregate function*/

SELECT AVG(Order_Total) AS 'Avg Total'
FROM t;

/*procedure that would display quantity greater than a parameterized number with a table with a quantity col*/

delimiter //
CREATE PROCEDURE aboveQuantity(lowerBound INT)
BEGIN
SELECT Category, Item
	FROM Products
WHERE Quantity > lowerBound;
END;
//

/*dropping multiple tables that are no longer needed in njit db*/

DROP TABLE EmployeeInfo;
DROP TABLE InventoryInfo;
DROP TABLE MSFT_StockData;
DROP TABLE Members;
DROP TABLE PatientHealthInfo;
DROP TABLE PatientInsuranceInfo;
DROP TABLE PatientMonetaryInfo;
DROP TABLE PatientPersonalInfo;
DROP TABLE Stock2010;

SELECT *
FROM OrderInfo, Books
WHERE OrderInfo.ISBN = Books.ISBN;

SELECT Title, SUM(OrderInfo.Qty)
FROM OrderInfo, Books
WHERE Books.ISBN = OrderInfo.ISBN
GROUP BY Title;

/*Books puchased by last name*/

SELECT First, Last, Id, Title
FROM Customers, Books, OrderInfo, Orders
WHERE Customers.Id = Orders.CustomerId
	AND Orders.OrderId = OrderInfo.OrderId
	AND OrderInfo.ISBN = Books.ISBN
	AND Last = 'Jones';
	
/*total orders by last name*/
SELECT Last, SUM(OrderInfo.Qty) AS 'Qty Purchased'
FROM Customers, Orders, OrderInfo, Books
WHERE Customers.Id = Orders.CustomerId
	AND Orders.OrderId = OrderInfo.OrderId
	AND OrderInfo.ISBN = Books.ISBN
GROUP BY Last;

SELECT c.Last, SUM(oI.Qty) AS 'Qty Purchased'
FROM Customers as c
	JOIN Orders as o ON o.CustomerId = c.Id
	JOIN OrderInfo as oI On oI.OrderId = o.OrderId
	JOIN Books as b ON b.ISBN = oI.ISBN 
GROUP BY c.Last;

/*Gehani join example*/
SELECT Title
FROM OrderInfo, Books
WHERE Books.ISBN = OrderInfo.ISBN;

SELECT DISTINCT Title
FROM OrderInfo JOIN Books
ON Books.ISBN = OrderInfo.ISBN

/*REDO OF EXAMPLES*/
SELECT c.Last, SUM(oI.Qty) AS 'Total Qty'
FROM Customers AS c
INNER JOIN Orders AS o ON c.Id = o.CustomerId
INNER JOIN OrderInfo AS oI ON o.OrderId = oI.OrderId
INNER JOIN Books AS b ON oI.ISBN = b.ISBN
WHERE c.Last = 'Jones';
