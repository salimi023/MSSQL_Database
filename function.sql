/* Scalar Function */

USE TBT
GO

/* Obtain the name of an employee based on business name and position */
CREATE OR ALTER FUNCTION staff.GetEmployeeName
(
    @Business VARCHAR(50),
    @Position VARCHAR(50)
)
RETURNS VARCHAR(50)
BEGIN	

    RETURN (SELECT CONCAT(emp.member_firstname, ' ', emp.member_lastname) AS Employee FROM staff.members AS emp 
    INNER JOIN staff.positions AS pos ON(emp.member_position = pos.pos_id)
    INNER JOIN business.[profile] AS prof ON(emp.bs_id = prof.bs_id)
    WHERE pos.pos_id = (SELECT pos_id FROM staff.positions WHERE pos_name = @Position) AND prof.bs_id = (SELECT bs_id FROM business.[profile] WHERE bs_shortName_hu = @Business)) 
	
END

SELECT staff.GetEmployeeName('RRB Kontrol Kft.', 'cégvezető')