drop table author;
drop sequence seq_author_id;



--테이블 만들기
create table author(
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
    );

    
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
    
    
    
--시퀀스 만들기
create sequence seq_author_id
increment by 1
start with 1
nocache;



--데이터 입력 author
insert into author
values(seq_author_id.nextval, '김문열', '경북 영양');

select * from author;

rollback;

--author 수정
update author
set author_name = '최문열',
    author_desc = '서울특별시'
where author_id = 1;



delete from author
where author_id = 5;


--select

select author_id,
       author_name,
       author_desc
from author;

rollback;




-----------------------------------------------
drop table author;
drop table book;

drop sequence seq_author_id;
drop sequence seq_book_id;


--테이블 만들기
create table author(
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
    );

    
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



--시퀀스 만들기
create sequence seq_author_id
increment by 1
start with 1
nocache;


create sequence seq_book_id
increment by 1
start with 1
nocache;






