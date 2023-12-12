-- 3-7 ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT
   * 
FROM
    Book
WHERE
    bookname LIKE '축구의 역사'
;

-- 3-8 도서이름에 ‘축구’가 포함된 출판사를 검색하시오.
SELECT 
    *
FROM
    Book
WHERE
    bookname LIKE '%축구%'
;
-- 3-9 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT 
    *
FROM
    Book
WHERE
    bookname LIKE '_구%'
;

-- '_구'
-- 가구
-- 나구
-- 다구
-- 라구
-- _구

-- '%구'
-- 구
-- 가구
-- 나구
-- 가나구
-- !구
-- @구
-- @@@구
-- ;


-- 3-10-1 축구에 관한 도서 중(제목에 '축구' 포함) 가격이 20,000원 이상인 도서를 검색하시오.
SELECT
    *
FROM
    Book
WHERE
    bookname LIKE '%축구%'
    AND price >= 20000;
    

-- 3-10-2 제목의 오른쪽에서 두번째 글자가 '기'인 책을 검색하시오
SELECT
    *
FROM
    Book
WHERE
    bookname LIKE '%기'
    ;

-- 3-11 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
SELECT 
    *
FROM
    Book
WHERE
    publisher = '굿스포츠'
        OR publisher = '대한미디어'
;

SELECT
    *
FROM
    Book
WHERE
    publisher IN ('굿스포츠', '대한미디어')
;   


-- 3-12 도서를 이름 오름차순으로 검색하시오.
SELECT
    *
FROM
    Book
ORDER BY
    bookname 
;


-- 3-13 도서를 가격 오름차순으로 검색하고, 가격이 같으면 이름 오름차순으로 검색하시오.
SELECT 
    bookid, bookname, publisher, price
FROM
    Book
ORDER BY price ASC , bookname ASC
;

-- 3-14 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
SELECT
    *
FROM
    Book
ORDER BY price DESC, publisher ASC
;

-- 3-15 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT
    SUM(saleprice) 
FROM
    Orders
;

SELECT
    SUM(saleprice) AS '총매출'
FROM
    Orders
;

-- 3-16 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT
    SUM(saleprice) AS "총매출"
FROM
    Orders
WHERE
    custid = 2
;

-- 3-17 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT
    SUM(saleprice) AS '총판매액',
    AVG(saleprice) AS '평균값',
    MIN(saleprice) AS '최저가',
    MAX(saleprice) AS '최고가'
FROM
    Orders
;

-- 3-18 마당서점의 도서 판매 건수를 구하시오.
SELECT
    COUNT(*)
FROM
    Orders
;


-- 3-19 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT
    custid, 
    COUNT(bookid) AS '도서수량',
    SUM(saleprice) AS '총액'
FROM
    Orders
GROUP BY custid
;

-- 3-20 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오
-- 단, 두 권 이상 구매한 고객만 구한다. 
SELECT 
    custid, COUNT(*) AS 도서수량
FROM 
    Orders
WHERE 
    saleprice >= 8000
GROUP BY 
    custid 
HAVING 
    COUNT(*) >= 2
;

-- 몇 번의 주문이 있었는지, 몇 명이 주문했는지를 구하시오
SELECT
    COUNT(orderid) as '총 주문 건수',
    COUNT(DISTINCT custid)
FROM
    Orders
;
-- 고객별 주문 도서의 총 수량을 구하시오. 
#단, 세 권 이상 구매한 고객만 구한다.
SELECT
    custid, COUNT(bookid)
FROM
    Orders
GROUP BY 
    custid
HAVING 
    COUNT(bookid) >= 3
;

SELECT custid, SUM(bookid)
FROM Orders
GROUP BY custid












