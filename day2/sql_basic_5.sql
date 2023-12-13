/*
Ch04 
SQL 고급
*/
USE madang;

# 내장함수
## 숫자함수 
SELECT ABS(-4.5);      -- 절대값
SELECT CEIL(4.1);      -- 올림   
SELECT FLOOR(4.1);     -- 내림  
SELECT ROUND(5.36);    -- 정수로 반올림
SELECT ROUND(5.36, 1); -- 소수점 첫재짜리까지 반올림  
SELECT LOG(10);        -- e 자연로그
SELECT LOG(2,10);      -- 밑이 2인 로그   
SELECT POWER(2,3);     -- 2의 3제곱
SELECT SQRT(9);        -- 제곱근
SELECT SIGN(3.45);     -- 음수면 -1, 0이면 0, 양수면 1

## 숫자함수 참고
SELECT bin(2);   -- 이진법
SELECT HEX(10);  -- 16진법
SELECT OCT(8);   -- 8진법


-- 4-1 -78과 +78의 절대값을 구하시오
SELECT ABS(-78), ABS(+78);

-- 4-2 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오
SELECT ROUND(4.875, 1);

-- 4-3 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오 
SELECT custid, 
        AVG(saleprice) AS 평균주문금액,
        ROUND(AVG(saleprice), -3) AS '평균주문금액(백원단위에서 반올림)' 
FROM Orders
GROUP BY custid;




## 문자함수
SELECT CONCAT('마당', '서점', '본점');
SELECT LOWER('MR. SCOTT');
SELECT UPPER('mr. scott');

SELECT LPAD('Page 1', 10, '*');
SELECT RPAD('abC', 5, '*');

SELECT REPLACE('JACK & JUE', 'J', 'BL');

SELECT SUBSTR('ABCDEFG', 3, 4);

SELECT TRIM('  BROWNING  ');
SELECT REPLACE('  BROWNING  ', ' ', '');

SELECT TRIM(' ' FROM '  BROWNING  ');

SELECT TRIM('=' FROM '==BROWNING==');

SELECT LENGTH('MYSQL');
SELECT LENGTH('마이에스큐엘');
SELECT CHAR_LENGTH('MYSQL');
SELECT CHAR_LENGTH('마이에스큐엘');

## 문자함수 참고
SELECT ASCII('A');
SELECT ASCII('a');
SELECT ASCII('!');

SELECT CHAR(77, 121, 83, 81, 76);
SELECT CONCAT_WS(',', '1st', '2nd', '3rd');    -- with separator
SELECT LEFT('mysql', 2);
SELECT RIGHT('mysql',3);
SELECT LTRIM('    mysql    '); -- 'mysql    '
SELECT RTRIM('    mysql    '); -- '    mysql'

;


USE madang;
-- 4-4 도서제목에 축구가 포함된 도서제목에서 '축구'를 '농구'로 변경한 이름을 출력하세요
SELECT bookname, REPLACE(bookname, '야구', '농구')
FROM Book
;

-- SELECT bookname, REPLACE(bookname, '축구', '농구')
-- FROM Book
-- WHERE bookname LIKE '축구%'
-- ;
-- UPDATE Book
-- SET bookname = REPLACE(bookname, '야구', '농구')
-- WHERE bookname LIKE '야구%'
-- ;

-- 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 출력하세요
SELECT bookname, CHAR_LENGTH(bookname) '문자수', LENGTH(bookname) '바이트수'
FROM Book
WHERE publisher = '굿스포츠';
 
-- 4-6 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 구하시오
SELECT SUBSTR(name, 1, 1), COUNT(1)
FROM Customer
GROUP BY SUBSTR(name, 1, 1)
;

-- SELECT ASCII('A');
-- SELECT ASCII('ABC');

-- SELECT '2019-02-14', ADDDATE('2019-02-14', INTERVAL 1 DAY); 

## 표4-4 날짜&시간함수의 종류
### 문자열 -> 날짜로 바꾸는 함수 STR_TO_DATE(string, 포맷)
SELECT STR_TO_DATE('2019-02-14', '%Y-%m-%d');
SELECT STR_TO_DATE('2019/02/14', '%Y/%m/%d');
SELECT STR_TO_DATE('20190214', '%Y%m%d');

SELECT STR_TO_DATE('2023-12-13', '%Y-%m-%d');

### 날짜 -> 문자열로 바꾸는 함수 DATE_FORMAT(date, 포맷)
SELECT DATE_FORMAT('2019-02-14', '%Y-%m-%d');
SELECT DATE_FORMAT('2019-02-14', '%Y/%m/%d');
SELECT DATE_FORMAT('2019-02-14', '%y/%m/%d');

### ADDDATE()
SELECT ADDDATE('2019-02-14', INTERVAL 10 DAY);
SELECT ADDDATE('2019-02-14', INTERVAL -10 DAY);
SELECT '2019-02-14' + INTERVAL 10 DAY;
SELECT '2019-02-14' - INTERVAL 10 DAY;

### Date()
SELECT DATE('2003-12-31 01:02:03');
SELECT YEAR('2003-12-31 01:02:03');
SELECT MONTH('2003-12-31 01:02:03');
SELECT DAY('2003-12-31 01:02:03');
SELECT HOUR('2003-12-31 01:02:03');
SELECT MINUTE('2003-12-31 01:02:03');
SELECT SECOND('2003-12-31 01:02:03');

### DATEDIFF
SELECT DATEDIFF('2019-02-14', '2019-02-04');  -- 10
SELECT DATEDIFF('2019-02-04', '2019-02-14');  -- -10
SELECT SYSDATE();
SELECT SYSDATE() + INTERVAL 9 HOUR;

## 날짜함수 포맷
SELECT SYSDATE(); # 지금 시간 반환 (UTC)
SELECT ADDDATE(SYSDATE(), INTERVAL 9 HOUR); # 지금 + 9시간 
SELECT SYSDATE() + INTERVAL 9 HOUR; # 지금 + 9시간 

SELECT SUBDATE(SYSDATE(), INTERVAL 10 DAY);
        

# 표4-5 format의 주요 지정자 
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%w');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%W');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%a');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%d');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%D');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%j');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%h');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%H');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%i');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%m');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%M');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%b');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%s');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%y');
SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR), '%Y');

SELECT DATE_FORMAT((SYSDATE() + INTERVAL 9 HOUR),
    '오늘은 %Y년 %m월 %d일 %W이며 %Y년의 %j번째 날입니다.');

-- 4-7 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderdate AS 주문일자, 
        ADDDATE(orderdate, INTERVAL 10 DAY) AS 확정일자
FROM Orders;

-- 4-8 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 보이시오. 
-- 단 주문일은 %Y-%m-%d형태로 표시한다
SELECT orderid, orderdate, custid, bookid
FROM Orders
WHERE orderdate = '2014-07-07';

-- 단 주문일은 '%Y년 %m월 %d일' 형태로 표시한다
SELECT orderid, 
        DATE_FORMAT(orderdate, '%Y년 %m월 %d일'), 
        custid, bookid
FROM Orders
WHERE orderdate = '2014-07-07'
;
-- 4-9 현재 DBMS의 날짜, 시간, 요일을 확인하시오
SELECT SYSDATE(),
        DATE_FORMAT(SYSDATE(), '%Y년 %m월 %d일'),
        DATE(SYSDATE()) AS 날짜,
        TIME(SYSDATE()) AS 시간,
        DATE_FORMAT(SYSDATE(), '%W') AS 요일
;



# NULL값 처리
-- 아직 지정되지 않은 값.
-- 0, ''(빈문자), ' '(공백)과 다른 특별한 값
-- 비교연산이나 문자, 숫자함수 수행시 결과는 NULL로 나온다 
SELECT NULL;
SELECT NULL + 1;
SELECT CONCAT('문자', NULL);
SELECT NULL < 100;
SELECT NULL = 0; -- SELECT 1 = 100 ;
SELECT NULL = NULL;

### NULL 값에 대한 연산과 집계 함수 
-- 집계함수 사용시 NULL이 포함된 행 집계에서 빠진다.
USE madang;
SELECT *
FROM Customer;

SELECT COUNT(*), COUNT(name), COUNT(phone) -- 5 5 4
FROM Customer;

-- 몇%의 고객이 휴대폰 정보를 입력하지 않았나요? 1/4 = 25% X
1/5 = 20%
SELECT count(1)
FROM Customer
WHERE phone is null;


-- 4-10 IS NULL, IS NOT NULL로 다뤄야 한다.
SELECT *
FROM Customer
WHERE phone IS NULL;
-- WHERE phone = NULL; XXXX

SELECT *
FROM Customer
WHERE phone IS NOT NULL;

-- IFNULL로 처리한다.
SELECT custid, name, address, phone, IFNULL(phone, '연락처 없음')
FROM Customer;

;
# 변수
-- 4-11 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.

### 쉬운 기술 법 
SELECT custid, name, phone
FROM Customer
WHERE custid < 3;

SELECT custid, name, phone
FROM Customer
LIMIT 2;
;

### 변수를 사용하는 방법
SET @seq:=0;
SELECT (@seq := @seq + 1) AS 순번, custid, name, phone
FROM Customer
Order by name;

-- 일반적인 경우에는 custid를 쓸 수 있지만 정렬 기준이 달라지는 경우
-- 쓸 수 없다.
SET @seq:=0;
SELECT (@seq := @seq + 1) AS 순번, custid, name, phone
FROM Customer
WHERE @seq < 2;
--
;

### 응용 
-- 판매건별로 누적매출을 구하시오
SET @v:=0;
SELECT orderid, custid, bookid, saleprice, orderdate,
    (@v := @v + saleprice) AS 누적매출
FROM Orders;

# Flow Control Function
SELECT *
FROM Orders;

## CASE문
SELECT orderid, saleprice,
        CASE WHEN saleprice < 10000 THEN '저가'
             WHEN saleprice >= 10000 AND saleprice < 20000 THEN '중가'
             ELSE '고가' END
FROM Orders;

SELECT orderdate, DATE_FORMAT(orderdate, '%a'),
        (CASE DATE_FORMAT(orderdate, '%a')
            WHEN 'Sat' THEN '주말'
            WHEN 'Sun' THEN '주말'
            ELSE '주중' END) week_or_weekend,
        saleprice
FROM Orders
;
-- 주중/주말별 평균 saleprice를 구하시오
SELECT week_or_weekend, AVG(saleprice)
FROM (
    SELECT orderdate, DATE_FORMAT(orderdate, '%a'),
        (CASE DATE_FORMAT(orderdate, '%a')
            WHEN 'Sat' THEN '주말'
            WHEN 'Sun' THEN '주말'
            ELSE '주중' END) week_or_weekend,
        saleprice
    FROM Orders) AS A
GROUP BY week_or_weekend;

# IF(expr1, expr2, expr3)
## expr1이 참일경우 expr2를 리턴, 거짓일 경우 expr3을 리턴
SELECT IF( 1 = 2, '참', '거짓');

SELECT bookname, price, IF(price <10000, '만원 미만', '만원 이상')
From Book;

# IFNULL(expr1, expr2)
##expr1이 NOT NULL일 경우 expr1을 리턴, NULL일 경우 expr2를 리턴
SELECT name, phone, IFNULL(phone, '정보 없음')
FROM Customer;

# 부속질의
## SELECT 부속질의
-- 단일행+단일열 결과
SELECT 1;
SELECT sum(saleprice) FROM Orders;

-- 단일열 결과
SELECT custid FROM Orders;

-- 4-12 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액을 출력).
SELECT (SELECT name 
        FROM Customer cs 
        WHERE cs.custid=od.custid) 'name', SUM(saleprice) 'total'
        
FROM Orders od
GROUP BY od.custid
;

-- 4-12 Orders 테이블에 각 주문에 맞는 도서이름을 출력하세요
SELECT bookid, (SELECT bookname 
                FROM Book as B 
                WHERE B.bookid = O.bookid)
FROM Orders as O
; 


## FROM 부속질의
-- 4-14 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).
SELECT *
FROM Customer
WHERE custid <= 2;

SELECT C.custid, C.name, SUM(saleprice)
FROM   Orders as O,
        (SELECT *
            FROM Customer
            WHERE custid <= 2) as C
WHERE O.custid = C.custid
GROUP BY C.custid, C.name;

## WHERE 부속질의
-- 4-15 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오
SELECT AVG(saleprice)
FROM Orders;

SELECT *
FROM Orders
WHERE saleprice <= (SELECT AVG(saleprice)
                    FROM Orders)
;

-- 4-16 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 
-- 주문번호, 고객번호, 금액을 보이시오.
SELECT *
FROM Orders;

SELECT custid, AVG(saleprice) AS avg_saleprice
FROM Orders
GROUP BY custid;
-- JOIN으로 푸는 방법
SELECT *
FROM Orders AS O,
    (SELECT custid, AVG(saleprice) AS avg_saleprice
    FROM Orders
    GROUP BY custid) as AA
WHERE O.custid = AA.custid
    AND avg_saleprice < saleprice;
-- where절 서브쿼리로 풀기 
SELECT *
FROM Orders AS O_1
WHERE saleprice > (SELECT AVG(saleprice)
                    FROM Orders AS O_2
                    WHERE O_1.custid = O_2.custid);
    

-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice)
FROM Orders
WHERE custid IN (SELECT custid
                    FROM Customer
                    WHERE address LIKE '%대한민국%')
;
SELECT custid
FROM Customer
WHERE address LIKE '%대한민국%';

-- (ALL 사용하는 문제지만 ALL 사용하지않아도 해결됨) 
-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와
--  금액을 보이시오.
# ALL 사용
SELECT *
FROM Orders
WHERE saleprice > ALL (SELECT saleprice
                        FROM Orders
                        WHERE custid = 3);
# ALL 미사용
SELECT *
FROM Orders
WHERE saleprice > ('3번고객 최고 주문 금액');

SELECT MAX(saleprice) FROM Orders WHERE custid = 3;

SELECT *
FROM Orders
WHERE saleprice > (SELECT MAX(saleprice) FROM Orders WHERE custid = 3);

-- (EXIST 활용하지 않아도 해결됨) 대한민국에 거주하는 고객에게 판매한 도서의
-- 총 판매액을 구하시오.
## EXIST 사용
SELECT *
FROM Orders as od
WHERE EXISTS (SELECT *
                FROM Customer as cs
                WHERE ADDRESS LIKE '%대한민국%'
                    AND cs.custid = od.custid);
## EXIST 미사용
SELECT *
FROM Orders as od
WHERE custid IN ('대한민국에 거주하는 고객의 id')
;
SELECT custid FROM Customer WHERE address LIKE '%대한민국%'

;
# 뷰
-- Book 테이블에서 제목에 ‘축구’라는 문구가 포함된 자료만 보여주는 뷰
SELECT *
FROM Book
WHERE bookname LIKE '%축구%'
    AND price >= 10000;
    
CREATE VIEW vw_book
AS
    SELECT *
    FROM Book
    WHERE bookname LIKE '%축구%'
        AND price >= 10000;     
;
SELECT * FROM vw_book;

SELECT * FROM Customer;

;
-- 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
-- Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.

## 뷰의 수정
-- vw_Customer는 주소가 대한민국인 고객을 보여준다. 이 뷰를 영국을 주소로 가진 고객으로 변경하시오. phone 속성은 필요 없으므로 포함시키지 마시오.

## 뷰의 삭제
-- 뷰 vw_Customer를 삭제하시오.

# 인덱스
-- 인덱스를 직접 만들 필요는 없지만 개념은 이해해야 합니다.


-- backup 
# Dual 테이블이란?
USE madang;
SELECT *, 1.1
FROM Book; 

SELECT *, 1.1, ROUND(1.1)
FROM Book;

SELECT ROUND(1.1)
FROM DUAL;

SELECT ROUND(1.1);
