SELECT
    lpad(' ', 4*(level-1)) || employee_id emp_id
FROM employees
START WITH manager_id is null
CONNECT BY PRIOR employee_id = manager_id;

SELECT
    e1.employee_id, e2.employee_id "<-- manager", e2.last_name || ' ' || e2.first_name name, e2.department_id
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.employee_id = 108;

SELECT
    employee_id, last_name || ' ' || first_name name, department_id
FROM employees
WHERE employee_id = (
    SELECT
        manager_id
    FROM employees
    WHERE employee_id = 104
);