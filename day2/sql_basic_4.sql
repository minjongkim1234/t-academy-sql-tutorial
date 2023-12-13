-- 데이터 제어어: CREATE, ALTER, DROP
-- 테이블을 건드림
-- CREATE 실습

/*
다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 정수형은 INTEGER를 사용하며 문자형은 가변형 문자타입인 VARCHAR을 사용한다. 
 bookid(도서번호)-INTEGER
 bookname(도서이름)-VARCHAR(20)
 publisher(출판사)-VARCHAR(20)
 price(가격)-INTEGER
*/
;
USE Test;

;
CREATE TABLE 테이블명 (
    칼럼명 칼럼데이터타입,
    칼럼명 칼럼데이터타입
)

;
CREATE TABLE NewBook (
    -- 칼럼명 칼럼데이터타입
    bookid      INTEGER,
    bookname    VARCHAR(20),
    publisher   VARCHAR(20),
    price       INTEGER
);
SELECT * FROM NewBook;
;

/*
다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
 custid(고객번호) - INTEGER, 기본키
 name(이름) – VARCHAR(40)
 address(주소) – VARCHAR(40)
 phone(전화번호) – VARCHAR(30)
*/
CREATE TABLE NewCustomer (
    -- 칼럼명 칼럼데이터타입,
    custid      INTEGER         PRIMARY KEY,
    name        VARCHAR(40),
    address     VARCHAR(40),
    phone       VARCHAR(30)
)
;
CREATE TABLE NewCustomer (
    -- 칼럼명 칼럼데이터타입,
    custid      INTEGER,
    name        VARCHAR(40),
    address     VARCHAR(40),
    phone       VARCHAR(30),
    PRIMARY KEY(custid)
)
;

/*
다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
 orderid(주문번호) - INTEGER, 기본키
 custid(고객번호) - INTEGER, NOT NULL 제약조건, 외래키(NewCustomer.custid, 연쇄삭제)
 bookid(도서번호) - INTEGER, NOT NULL 제약조건
 saleprice(판매가격) - INTEGER 
 
 orderdate(판매일자) – DATE
*/
USE Test;

CREATE TABLE Test.NewOrders (
    orderid INTEGER,
    custid INTEGER NOT NULL,
    bookid INTEGER NOT NULL,
    saleprice INTEGER,
    orderdate DATE,
    PRIMARY KEY (orderid)
    -- FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
);

-- madang데이터베이스의 Book테이블과 동일한 이름과 구조의 테이블을 각자의 데이터베이스(Zxx)에 생성하시오
CREATE TABLE Book (
    bookid      INTEGER,
    bookname    VARCHAR(40),
    publisher   INTEGER,
    price       VARCHAR(40)
)
;
DROP TABLE Book;
;
-- Error Code: 1050. Table 'Book' already exists

;
select * from Test.Book
;
-- CREATE TABLE ...LIKE
CREATE TABLE Test.Book LIKE madang.Book;

-- madang데이터베이스의 Imported_Book테이블과 동일한 이름과 구조의 테이블을 각자의 데이터베이스(Zxx)에 생성하시오
SELECT * FROM madang.Imported_Book;
-- CREATE TABLE z00.Imported_Book (
--     bookid ...
--     bookname ...
-- )

CREATE TABLE Test.Imported_Book
SELECT * FROM madang.Imported_Book;
;
SELECT * FROM Test.Imported_Book;

-- madang데이터베이스의 Customer테이블과 동일한 이름과 구조의 테이블을 각자의 데이터베이스(Zxx)에 생성하시오

/*
madang테이블의 Book, Customer, Orders, Imported_Book테이블과 동일한 구조와 동일한 데이터를 가지는 테이블을
각자의 데이터베이스에 생성하시오
*/
CREATE TABLE Book SELECT * FROM madang.Book;
CREATE TABLE Customer SELECT * FROM madang.Customer;
CREATE TABLE Orders SELECT * FROM madang.Orders;
CREATE TABLE Imported_Book SELECT * FROM madang.Imported_Book;

-- ALTER 실습
-- NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가하시오.
SELECT * FROM NewBook;

-- CREATE TABLE NewBook
-- DROP TABLE NewBOok
-- ALTER TABLE NewBook ADD 칼럼명 칼럼데이터타입;
ALTER TABLE NewBook ADD isbn VARCHAR(13);

-- NewBook 테이블의 isbn 속성의 데이터 타입을 INTEGER형으로 변경하시오.
-- ALTER TABLE 테이블명 ADD/MODIFY/DROP 칼럼정보
ALTER TABLE NewBook MODIFY isbn INTEGER;

-- NewBook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE NewBook DROP isbn;

-- NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE NewBook MODIFY bookid INTEGER NOT NULL;


SELECT * FROM Imported_Book;
ALTER TABLE Imported_Book MODIFY publisher INTEGER;
ALTER TABLE Imported_Book MODIFY bookid VARCHAR(5);

/*
CREATE TABLE NewBook (
    bookid INTEGER
    => bookid INTEGER NOT NULL
    ...
    ...
)
*/

-- NewBook 테이블의 bookid 속성을 기본키로 변경하시오.
ALTER TABLE NewBook ADD PRIMARY KEY (`bookid`);

SELECT * FROM NewBook;
-- 여러개의 column을 한번에 ALTER하는 방법
ALTER TABLE NewBook
    MODIFY bookname int,
    MODIFY bookname DECIMAL;

-- 내부데이터가 들어있는 상황에서 MODIFY해버리면 형변환이 된다.
-- ex. DECIMAL이었는데 INTEGER로 MODIFY해버리면?


-- DROP 실습
-- NewBook 테이블을 삭제하시오.
DROP TABLE Test.NewBook;

SELECT * FROM Test.NewBook;
-- Error Code: 1146. Table 'z00.NewBook' doesn't exist

-- NewCustomer 테이블을 삭제하시오. 만약 삭제가 거절된다면 원인을 파악하고 관련된 테이블을 같이 삭제하시오(NewOrders 테이블이 NewCustomer를 참조하고 있음).
DROP TABLE NewCustomer;

-- 참조하고 있는 테이블을 먼저 삭제후 삭제하면 됩니다.
DROP TABLE NewOrders;
DROP TABLE NewCustomer;

/*
Error Code: 3730. Cannot drop table 'NewCustomer' 
referenced by a foreign key constraint 'NewOrders_ibfk_1' on table 'NewOrders'.
*/



-- 데이터 조작어: INSERT, UPDATE, DELETE
-- 테이블내의 데이터를 건드림

-- INSERT 실습
-- Book 테이블에 새로운 도서 ‘스포츠 의학’을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90,000원이다.
SELECT * FROM Book 
order by bookid desc;

INSERT INTO 테이블이름(칼럼 리스트)
    VALUES (값 리스트)
;
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES (11, '스포츠 의학', '한솔의학서적', 90000);


-- Book 테이블에 새로운 도서 ‘스포츠 의학’을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 미정이다.
INSERT INTO Book(bookid, bookname, publisher)
    VALUES (11, '스포츠 의학', '한솔의학서적');

/*
-- 칼럼 위치 바꿔도 됨
INSERT INTO Book(bookid, publisher, bookname)
    VALUES (12, '한솔의학서적', '스포츠의학');
*/

-- bookname, publisher, price는 default값으로 insert된다
INSERT INTO Book(bookid)
    VALUES (13);
;
INSERT INTO Book(publisher, bookname, price)
    VALUES ('한솔의학서적', '스포츠의학', 90000);

-- NOT NULL 제약조건이 걸려있는데 bookid를 입력하지 않아 생기는 오류
-- Error Code: 1364. Field 'bookid' doesn't have a default value;

-- 수입도서 목록(Imported_book)을 Book 테이블에 모두 삽입하시오.
SELECT * FROM Book order by 1 desc;
SELECT * FROM Imported_Book;
-- 하나씩 입력
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Book()
    VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);
;
-- 2 row(s) affected Records: 2  Duplicates: 0  Warnings: 0
-- 테이블 구조가 동일하니 실행됨 
INSERT INTO Book
        SELECT * FROM Imported_Book;
  
-- 구조가 다르면 에러가 난다
INSERT INTO Book
    SELECT * FROM Customer;


-- 10000원 이상인 수입서적만 insert하는 쿼리


INSERT INTO Book
        SELECT * FROM Imported_Book
        WHERE price >= 10000
        ;



-- UPDATE 실습
-- Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
Select *
From Customer;
/*
SELECT
FROM
WHERE
*//*
UPDATE 테이블명
SET    칼럼명 = 값
WHERE  조건
*/
SET SQL_SAFE_UPDATES=0; 

UPDATE Customer
SET    address = '대한민국 부산';
-- WHERE  custid = 5;

/*Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.*/


-- Book 테이블에서 14번 ‘스포츠 의학’의 출판사를 imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오.
/*
-- 14번 데이터 insert해주기
INSERT INTO Book(bookid, bookname, publisher) VALUES (14, '스포츠 의학', '한솔의학서적');
*/
UPDATE Book 
SET 
    publisher = (SELECT 
            publisher
        FROM
            Imported_Book
        WHERE
            bookid = 21)
WHERE
    bookid = 14;
;
SELECT publisher
FROM Imported_Book
WHERE bookid = 21;
SELECT * FROM Book WHERE bookid = 14;



-- DELETE 실습
-- Book 테이블에서 도서번호가 11인 도서를 삭제하시오.
DELETE FROM 테이블명
WHERE 조건;

SELECT * FROM Book;

DELETE FROM Book
WHERE bookid = 11;


-- 모든 고객을 삭제하시오.
DELETE FROM Customer;
;
SELECT * FROM Customer;

-- 테이블까지 삭제하려면 DROP TABLE Customer;

-- 질문
-- DROP과 DELETE의 차이는?  DROP은 테이블, DELETE는 테이블 내 데이터  삭제 
-- ALTER과 UPDATE의 차이는?                                    수정
-- CREATE와 INSERT의 차이는?                                   생성