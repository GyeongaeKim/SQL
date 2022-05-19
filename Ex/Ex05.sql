create table author(
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
    );


--■ DML(Data Manipulation Language, 데이터 조작어) --> 테이블 관리
--■ 묵시적 방법
--• 컬럼 이름, 순서 지정하지 않음.
--• 테이블 생성시 정의한 순서에 따라 값 지정
insert into author 
values(1, '박경리' , '토지 작가');


--■ 명시적 방법
--• 컬럼 이름명시적 사용
--• 지정되지 않은 컬럼 NULL 자동입력
insert into author(author_id, author_name)
values(2, '이문열' );

insert into author(author_name, author_id)
values('기안84', 3);


select *
from author;



create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
    );





select * 
from book;


--1, 토지, 마로니에북스, 2012-08-15,
insert into book
values(1, '토지', '마로니에북스', '15-aug-2012', 1);

--2, 삼국지, 민음사, 2002-03-01, 2
insert into book
values(2, '삼국지', '민음사', '01-mar-2002', 2);

--■ 조건을 만족하는 레코드를 변경
--• 컬럼 이름, 순서 지정하지 않음.
--• 테이블 생성시 정의한 순서에 따라 값 지정
update author
set author_desc = '삼국지 작가'
where author_id = 2;


update author
set author_desc = '웹툰작가'; --where조건이 없으면 모든 author_desc가 일괄변경됨..


update author
set author_name = '김경리',
    author_desc = '토지 작가'
where author_id = 1;


--■ 조건을 만족하는 레코드를 삭제
--■ 조건이 없으면 모든 데이터 삭제(주의)
DELETE FROM author
WHERE author_id = 1 ;



delete from book;




drop table book;

drop table author;













