-- 3-21-1 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT
    *
FROM
    Customer, Orders 
WHERE
    Customer.custid = Orders.custid
;

-- 3-21-2 Alias 사용, 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT
    *
FROM
    Customer as C,
    Orders as O
WHERE
    C.custid = O.custid
;


-- 3-22 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.
SELECT
    *
FROM
    Customer, 
    Orders
WHERE
    Customer.custid = Orders.custid
ORDER BY Customer.custid

;

-- 3-23 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT
    name, saleprice
FROM
    Customer , Orders 
WHERE
    Customer.custid = Orders.custid
ORDER BY Customer.custid
;

-- 3-24 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT
    Customer.custid, name, SUM(saleprice)
FROM
    Customer, Orders 
WHERE
    Customer.custid = Orders.custid
GROUP BY 1   -- C.custid
ORDER BY 1   -- C.custid
;

-- 3-25 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT
    Customer.name, Book.bookname
FROM
    Customer, Orders, Book 
WHERE
    Customer.custid = Orders.custid
    AND Orders.bookid = Book.bookid
;

-- 3-26 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT
    Customer.name, Book.bookname, Orders.saleprice, Book.price
FROM
    Customer, Orders, Book 
WHERE
    Customer.custid = Orders.custid
    AND Orders.bookid = Book.bookid
    AND Book.price >= 20000
;

-- 외부 조인 
-- 3-27 도시를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도시의 판매가격을 구하시오
SELECT Customer.name, saleprice 
FROM Customer LEFT OUTER JOIN Orders 
        ON Customer.custid = Orders.custid
;

# 부속질의(서브쿼리)
-- 3-28 가장 비싼 도서의 이름을 보이시오.
SELECT 
    bookname 
FROM 
    Book 
WHERE 
    price = (SELECT MAX(price) FROM Book)
;

-- 3-29 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
#도서구매내역있는 사람의 아이디를 먼저 구하고
SELECT
    DISTINCT custid
FROM
    Orders
;
#이를 서브쿼리로 활용해보자
SELECT 
    name
FROM
    Customer
WHERE
    custid IN (
        SELECT 
            DISTINCT custid
        FROM
            Orders)
;

-- 3-30 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오. 
SELECT name 
FROM Customer
WHERE custid IN (SELECT custid 
                FROM Orders 
                WHERE bookid IN (SELECT bookid 
                                FROM Book 
                                WHERE publisher='대한미디어'));

-- 3-31 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT b1.bookname 
FROM Book b1 
WHERE b1.price > (  SELECT AVG(b2.price)
                    FROM Book b2 
                    WHERE b2.publisher=b1.publisher);

-- 3-32 대한민국에서 거주하는 고객의 이름과 도시를 주문한 고객의 이름을 보이시오 
SELECT name 
FROM Customer 
WHERE address LIKE '대한민국%'

SELECT name 
FROM Customer 
WHERE custid IN (SELECT custid FROM Orders);


SELECT name 
FROM Customer 
WHERE address LIKE '대한민국%'
UNION 
SELECT name 
FROM Customer 
WHERE custid IN (SELECT custid FROM Orders);

-- 3-33 주문이 있는 고객의 이름과 주소를 보이시오 
SELECT name, address 
FROM Customer cs 
WHERE EXISTS (  SELECT * 
                FROM Orders od 
                WHERE cs.custid = od.custid);


SELECT
    publisher, avg(price) AS avg_price
FROM
    Book
GROUP BY publisher
;

select * from book
;

SELECT 
    *
FROM
    Book AS b1,
    (SELECT 
        publisher, AVG(price) AS avg_price
    FROM
        Book
    GROUP BY publisher) AS b2
WHERE b1.publisher = b2.publisher
    AND b1.price > b2.avg_price
    




SELECT
    *
FROM
    book
ORDER BY price DESC
LIMIT 1
;

SELECT
    MAX(price)
FROM
    book
;
SELECT 
    *
FROM
    book
WHERE
    price = (
        SELECT 
            MAX(price)
        FROM
            book)
;