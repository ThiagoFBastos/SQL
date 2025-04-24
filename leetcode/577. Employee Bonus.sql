SELECT name, bonus
FROM Employee E LEFT JOIN Bonus B ON E.empId = B.empId
WHERE B.bonus IS NULL OR B.bonus < 1000;