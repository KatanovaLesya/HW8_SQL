-- Выполните ряд записей вставки в виде транзакции в хранимой процедуре. 
-- Если такой сотрудник имеется откатите базу данных обратно. 

-- Відповідь:
-- Танзакція у хранимій процедурі.

DELIMITER |
DROP PROCEDURE MyTransactProc; |
CREATE PROCEDURE MyTransactProc (IN name varchar(20), IN phone varchar(15), IN mstatus varchar(20), IN birth Date, 
IN adress varchar(30), IN pos varchar(30), IN salary int)

BEGIN
DECLARE Id int;
START TRANSACTION;
			
		INSERT Employees (NameEmployee, PhoneEmployee)
		VALUES (name, phone);
       
       SET Id = @@IDENTITY;
       
		INSERT Personal (PersonalID, MaritalStatus, BirthDay, Adress)
		VALUES (Id, mstatus,birth,adress);
		
		INSERT Positions (PositionID, PositionEmployee, SalaryEmployee)
		VALUES (Id, pos, salary);
		
IF EXISTS (SELECT * FROM Employees WHERE NameEmployee = name AND PhoneEmployee = phone AND EmployeesID != Id)
			THEN
				ROLLBACK; 
			END IF;	
		COMMIT; 
END; |	

 
CALL MyTransactProc('Mykola Kalishenko', '+380663539435','married', '1982-09-19', 'KYIV', 'CFO', 65000); |
CALL MyTransactProc('Mykola Kalishenko', '+380663539435','married', '1982-09-19', 'KYIV', 'CFO', 65000); |
CALL MyTransactProc ('Stefa Kalishenko', '+380503539435','unmarried', '2004-01-11', 'KYIV', 'Bookkiper', 20000); |

SELECT * FROM Employees;  |
SELECT * FROM Personal;  |
SELECT * FROM Positions;  |