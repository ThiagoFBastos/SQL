SELECT department.name as Department, employee.name as Employee, salary as Salary
FROM Employee LEFT JOIN Department 
ON Employee.departmentId = Department.id
WHERE (SELECT count(DISTINCT e1.salary) FROM Employee as e1 WHERE e1.salary > Employee.salary AND e1.departmentId = Employee.departmentId) < 3