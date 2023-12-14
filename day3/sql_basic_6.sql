
# With 문 
-- 가상의 테이블을 만드는 문법
-- 쿼리의 가독성을 높여준다.
-- FROM절 subquery나 where절 subquery를 with문으로 처리하면 가독성이 높아진다.
-- SELECT뿐만 아니라 다른 키워드와도 함께 사용될 수 있다.
-- WITH ... SELECT ...
-- WITH ... UPDATE ...
-- WITH ... DELETE ...
WITH
  tmp1 AS (SELECT a, b FROM table1),
  tmp2 AS (SELECT c, d FROM table2)
SELECT b, d 
FROM tmp1, tmp2
WHERE tmp1.a = tmp2.c;

### 고객번호가 2 이하인 고객의 판매액을 보이시오
USE madang;
-- 기존 풀이
SELECT C.custid, C.name, SUM(saleprice)
FROM   Orders as O,
        (SELECT *
            FROM Customer
            WHERE custid <= 2) as C
WHERE O.custid = C.custid
GROUP BY C.custid, C.name;

-- 임시테이블 활용
CREATE TABLE tmp_table 
    SELECT *
    FROM Customer
    WHERE custid <= 2;
    
SELECT C.custid, C.name, SUM(saleprice)
FROM   Orders as O,
       tmp_table as C
WHERE O.custid = C.custid
GROUP BY C.custid, C.name;

DROP TABLE tmp_table;

-- with문 활용
WITH tmp_table AS (
    SELECT *
    FROM Customer
    WHERE custid <= 2)
SELECT C.custid, C.name, SUM(saleprice)
FROM   Orders as O,
       tmp_table as C
WHERE O.custid = C.custid
GROUP BY C.custid, C.name;



# Window Function

-- 순위를 매기는 함수
-- MySQL 8부터 지원. MySQL 5는 Window Function 지원 안 함.
-- 주요 window function
    -- ROW_NUMBER()
    -- RANK()
    -- DENSE_RANK()
### 문법
WINDOW_FUNCTION() OVER() -- 아무 조건이 주어지지 않은 상태
WINDOW_FUNCTION() OVER(ORDER BY col1) -- col1의 오름차순대로 순위를 매김
WINDOW_FUNCTION() OVER(ORDER BY col1 DESC) -- col1의 내림차순대로 순위를 매김

-- col1끼리 순위를 매기는데 조건은 col2의 오름차순
WINDOW_FUNCTION() OVER(PARTITION BY col1 ORDER BY col2) 
-- col1, col2의 유니크한 조합별로 순위를 매기는데 조건은 col3의 오름차순
WINDOW_FUNCTION() OVER(PARTITION BY col1, col2 ORDER BY col3)

### 주요 Windows Function 
-- RANK 함수
--    중복 값에 대해서 동일한 순위 그리고
--    중복 값 다음 값에 대해서 중복순위 + 중복값 개수 의 순위를 출력합니다.
    
-- DENSE_RANK 함수
--    중복 값에 대해서 동일한 순위 그리고
--    중복 값 다음 값에 대해서 중복순위 + 1 의 순위를 출력합니다.
    
-- ROW_NUMBER 함수
--    중복 값에 대해서 순차적인 순위 그리고
--    중복 값 다음 값에 대해서 또한 순차적인 순위를 출력합니다.

### 예시
USE hr;

select * from employees;

-- 조건이 주어지지 않았을때 vs ORDER BY 조건
SELECT employee_id, first_name, last_name, department_id, salary,
    RANK() OVER(),
    RANK() OVER(ORDER BY salary),
    RANK() OVER(ORDER BY salary DESC)
FROM employees;

-- RANK, DENSE_RANK, ROW_NUMBER 비교
SELECT employee_id, first_name, last_name, department_id, salary,
    RANK() OVER(ORDER BY salary),
    DENSE_RANK() OVER(ORDER BY salary),
    ROW_NUMBER() OVER(ORDER BY salary)
FROM employees
ORDER BY salary;

-- PARTITION BY 조건
SELECT employee_id, first_name, last_name, department_id, job_id, salary,
    ROW_NUMBER() OVER(),
    ROW_NUMBER() OVER(ORDER BY salary),
    ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary),
    ROW_NUMBER() OVER(PARTITION BY department_id, job_id ORDER BY salary)
FROM employees
ORDER BY department_id, job_id, salary;