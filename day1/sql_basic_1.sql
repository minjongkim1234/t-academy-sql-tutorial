

-- 3-1-1 모든 도서의 이름과 가격을 검색하시오
SELECT 
    bookname, price 
FROM
    Book
;

-- 3-1-2 모든 도서의 가격과 이름을 검색하시오. 
SELECT
    price, bookname
FROM
    Book
;

-- 3-2-1 모든 도서의 도서번호,  도서이름, 출판사, 가격을 검색하시오
SELECT
    bookid, bookname, publisher, price
FROM
    Book
;

-- 3-2-2 모든 도서의 도서번호,  도서이름, 출판사, 가격을 검색하시오
SELECT
    *
FROM
    Book
;

-- 3-3-1 도서 테이블에 있는 모든 출판사를 검색하시오
SELECT
    publisher
FROM
    Book
;

-- 3-3-2 중복을 제거하고 싶으면 DISTINCT를 사용한다. 
SELECT
    DISTINCT publisher
FROM
    Book
;


-- 3-4 가격이 20,000원 미만인 도서를 검색하시오
SELECT 
    * 
FROM 
    Book 
WHERE 
    price < 20000
;

-- 3-5-1 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오
SELECT 
    * 
FROM 
    Book 
WHERE 
    price BETWEEN 10000 AND 20000
;

-- 3-5-2 논리연산자 AND 를 사용한 표현  
SELECT 
    * 
FROM 
    Book 
WHERE 
    price >= 10000 AND price <= 20000
;

-- 3-6-1 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오 
SELECT 
    * 
FROM 
    Book 
WHERE 
    publisher IN ('굿스포츠', '대한미디어')
;

-- 3-6-2 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오
SELECT 
    * 
FROM 
    Book 
WHERE 
    publisher NOT IN ('굿스포츠', '대한미디어')
;

