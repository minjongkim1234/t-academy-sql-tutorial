/*
Ch 3. 연습문제
*/

USE madang;

#01
# 1~3
-- (1) 도서번호가 1인 도서의 이름
SELECT
    bookname
FROM
    book
WHERE bookid=1;

-- (2) 가격이 20000원 이상인 도서의 이름 
SELECT
    bookname
FROM
    book
WHERE
    price >= 20000;

-- (3) 박지성의 총 구매액
# 박지성의 custid를 알아내면 된다
select custid from Customer where name = '박지성';
# 서브쿼리 사용
SELECT 
    SUM(saleprice)
FROM
    Orders
WHERE
    custid = (
        SELECT 
            custid
        FROM
            Customer
        WHERE
            name = '박지성')
;

-- (4) 박지성이 구매한 도서의 수
SELECT COUNT(bookid)
FROM
    orders AS O,
    customer AS C
WHERE O.custid = C.custid
    and C.name = '박지성'
;    
-- (5) 박지성이 구매한 도서의 출판사 수
SELECT
    COUNT(DISTINCT publisher)
FROM
    orders as O,
    customer as C,
    book as B
WHERE
    O.custid = C.custid
    AND O.bookid = B.bookid
    AND c.name = '박지성'
;
-- (6) 박지성이 구매한 도서의 이름, 정가, 정가와 판매가격의 차이
SELECT
    B.bookname AS 이름,
    B.price AS 정가,
    B.price - O.saleprice AS '정가와 판매가격의 차이'
FROM
    customer as C,
    orders as O,
    book as B
WHERE
    O.custid = C.custid AND O.bookid = B.bookid
    AND c.name = '박지성'
;

;
-- (7) 박지성이 구매하지 않은 도서의 이름
# 박지성이 구매한 도서 먼저 구해봅시다
SELECT
    bookid
FROM
    customer as C,
    orders as O
WHERE
    C.custid = O.custid
    AND C.name = '박지성'
    ;
# 위의 쿼리를 서브쿼리로
SELECT 
    *
FROM
    book
WHERE
    bookid NOT IN (
        SELECT 
            bookid
        FROM
            customer AS C,
            orders AS O
        WHERE
            C.custid = O.custid AND C.name = '박지성')


;
#02
# 1 ~7
-- (1) 마당서점 도서의 총 개수
SELECT
    count(bookid)
FROM
    book
;
-- (2) 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT 
    COUNT(DISTINCT publisher)
FROM
    book
;
-- (3) 모든 고객의 이름, 주소
SELECT 
    name, address
FROM
    Customer;
-- (4) 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서의 주문번호
SELECT
    orderid
FROM
    Orders
WHERE
    orderdate BETWEEN '2014-07-04' AND '2014-07-07'
;

-- (5) 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
SELECT
    orderid
FROM
    Orders
WHERE
    orderdate NOT BETWEEN '2014-07-04' AND '2014-07-07';
-- (6) 성이 '김'씨인 고객의 이름과 주소
SELECT
    name, address
FROM
    customer
WHERE
    name LIKE '김%'
;
-- (7) 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT
    name, address
FROM
    customer
WHERE
    name LIKE '김%아';
;
-- (9) 주문 금액의 총액과 주문의 평균 금액
SELECT
    SUM(saleprice), AVG(saleprice)
FROM
    Orders
;

-- (10) 고객의 이름과 고객별 구매액
SELECT 
    C.custid, C.name, SUM(saleprice)
FROM
    Orders as O,
    Customer as C
WHERE
    O.custid = C.custid
GROUP BY C.custid, C.name;

-- (11) 고객의 이름과 고객이 구매한 도서 목록(도서 이름과 고객의 이름이 테이블 형태로 나와야 함)
SELECT
    C.name, B.bookname
FROM
    Customer as C,
    Orders as O,
    Book as B
WHERE
    C.custid = O.custid
    AND O.bookid = B.bookid
ORDER BY B.price
;

-- (12) 도서의 가격(Book테이블)과 판매가격(Orders테이블)의 차이가 가장 큰 주문
SELECT
    orderid, BB.price, AA.saleprice, BB.price - AA.saleprice
FROM
    Orders AS AA,
    Book AS BB
WHERE
    AA.bookid = BB.bookid
ORDER BY 4 DESC
LIMIT 1
;
-- 
SELECT
    *
FROM
    Orders as O,
    Book as B
WHERE
    O.bookid = B.bookid
ORDER BY (price-saleprice)
;
-- MAX 사용  
SELECT
    MAX(price-saleprice)
FROM
    Orders as O,
    Book as B
WHERE
    O.bookid = B.bookid
;
SELECT 
    *
FROM
    Orders AS O,
    Book AS B
WHERE
    O.bookid = B.bookid
        AND price - saleprice = (
        SELECT 
            MAX(price - saleprice)
        FROM
            Orders AS O,
            Book AS B
        WHERE
            O.bookid = B.bookid)
            
;
-- 예시. 이벤트 대상 추출 쿼리
SELECT
    userid
FROM
    users
WHERE
    login_date <= '2021-05-01'
    AND ...
    AND (subquery)
    AND (subquery (subquery) )
;


-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
# 도서의 판매액 평균
SELECT
    AVG(saleprice)
FROM
    Orders
;
# 자신의 구매액 평균 = 고객의 구매액 평균
SELECT
    custid, AVG(saleprice) AS avg_price
FROM
    Orders
GROUP BY custid
-- HAVING AVG(saleprice) > 판매액평균

;
SELECT 
    custid, AVG(saleprice) AS avg_price
FROM
    Orders
GROUP BY custid
HAVING AVG(saleprice) > (
    SELECT 
        AVG(saleprice)
    FROM
        Orders)
;
SELECT 
    O.custid,
    (SELECT name FROM Customer WHERE custid =  O.custid),
    AVG(saleprice) AS avg_price
FROM
    Orders as O
GROUP BY custid
HAVING AVG(saleprice) > (
    SELECT 
        AVG(saleprice)
    FROM
        Orders)




;



        
        
;
-- EX. JOIN시 한 테이블의 모든 칼럼만 가져오는 방법.
SELECT
    O.*
FROM
    Orders as O,
    Book as B
WHERE
    O.bookid = B.bookid;


#03
-- (1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
# 박지성이 구매한 도서의 출판사를 구하세요


SELECT DISTINCT C.name 
FROM 
    Customer AS C,
    Orders AS O,
    Book AS B
WHERE 
    C.custid = O.custid  
    AND B.bookid = O.bookid
    AND publisher IN (
                    SELECT publisher 
                    FROM Book AS B
                    WHERE bookid IN (   SELECT bookid
                                        FROM 
                                            Customer AS C, 
                                            Orders AS O
                                        WHERE C.custid = O.custid AND C.name = '박지성'))




SELECT
    bookid
FROM
    Customer as C,
    Orders as O
WHERE
    C.custid = O.custid
    AND C.name = '박지성'
;
SELECT 
    publisher
FROM
    Book
WHERE
    bookid IN (
        SELECT 
            bookid
        FROM
            Customer AS C,
            Orders AS O
        WHERE
            C.custid = O.custid AND C.name = '박지성')
;
SELECT 
    distinct name
FROM
    Customer AS C,
    Orders AS O,
    Book AS B
WHERE
    C.custid = O.custid
        AND O.bookid = B.bookid
        AND B.publisher IN (
        SELECT 
            publisher
        FROM
            Book
        WHERE
            bookid IN (
                SELECT 
                    bookid
                FROM
                    Customer AS C,
                    Orders AS O
                WHERE
                    C.custid = O.custid AND C.name = '박지성'))
;
-- 도전 서브쿼리 1번 쓰기
SELECT 
    DISTINCT name
FROM
    Orders AS O, Customer AS C, Book AS B
WHERE
    O.custid = C.custid
        AND O.bookid = B.bookid
        AND publisher IN (
        SELECT 
            publisher
        FROM
            Orders AS O, Customer AS C, Book AS B
        WHERE
            O.custid = C.custid
                AND O.bookid = B.bookid
                AND C.name = '박지성')
;
-- (2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름

SELECT C.custid 
FROM Customer AS C, Book AS B, Orders AS O 
WHERE O.custid = C.custid AND O.bookid = B.bookid 
GROUP BY C.custid



SELECT C.custid, C.name, COUNT(DISTINCT publisher)
FROM Customer as C, Orders as O, Book as B
WHERE C.custid = O.custid AND O.bookid = B.bookid
GROUP BY C.custid, C.name
HAVING COUNT(DISTINCT publisher) >= 2
;
SELECT (SELECT name FROM Customer WHERE custid = C.custid)
    , COUNT(DISTINCT publisher)
FROM Customer as C, Orders as O, Book as B
WHERE C.custid = O.custid AND O.bookid = B.bookid
GROUP BY C.custid
HAVING COUNT(DISTINCT publisher) >= 2



;
-- (3) 전체 고객의 30% 이상이 구매한 도서
SELECT COUNT(1)*0.3 FROM Customer;

-- 도서이름: 몇명이 구매했는지
SELECT bookid, COUNT(DISTINCT custid)
FROM Orders
GROUP BY bookid
HAVING COUNT(DISTINCT custid) >= (SELECT COUNT(1)*0.3 FROM Customer)
;

SELECT B.bookid, B.bookname, COUNT(DISTINCT custid)
FROM Orders AS O, Book AS B
WHERE O.bookid = B.bookid
GROUP BY O.bookid
HAVING COUNT(DISTINCT custid) >= (SELECT COUNT(1)*0.3 FROM Customer)

;

SELECT *
FROM ORDERS
WHERE
    -- ORDERDATE BETWEEN '20140704' AND '20140707'
    -- ORDERDATE BETWEEN '2014/07/04' AND '2014/07/07'
    ORDERDATE BETWEEN '2014-07-04' AND '2014-07-07'


