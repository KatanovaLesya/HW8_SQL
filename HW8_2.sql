-- Создайте триггер, который будет удалять записи со 2-й и 3-й таблиц перед удалением записей из таблиц сотрудников 
-- (1-й таблицы), чтобы не нарушить целостность данных.



DELIMITER |
CREATE TRIGGER delete_employees
BEFORE DELETE ON Employees 
FOR EACH ROW 
  BEGIN
    DELETE FROM Personal WHERE   PersonalID  = OLD.EmployeesID;
    DELETE FROM Positions WHERE  PositionID = OLD.EmployeesID;
 END;
    |
    
DELETE FROM Employees WHERE EmployeesID = 3; |

SELECT * FROM Employees; |
SELECT * FROM Positions; |
SELECT * FROM Personal; |

DROP TRIGGER IF EXISTS delete_employees; |