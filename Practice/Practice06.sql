drop table author;
drop sequence seq_author_id;
drop table book;
drop sequence seq_book_id;

select * from author;
select * from book;

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
    pubs varchar2(500),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
    );
    
    
--시퀀스 만들기
create sequence seq_book_id
increment by 1
start with 1;

create sequence seq_author_id
increment by 1
start with 1;





--데이터 입력 author
insert into author
values(seq_author_id.nextval, '김문열', '경북 영양');

insert into author
values(seq_author_id.nextval, '박경리', '경상남도 통양');

insert into author
values(seq_author_id.nextval, '유시민', '제 17대 국회의원');

insert into author
values(seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values(seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values(seq_author_id.nextval, '김영하', '알쓸신잡');






--데이터 입력 book
insert into book
values(seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '22-feb-1998', 1);

insert into book
values(seq_book_id.nextval, '삼국지', '민음사', '01-mar-2002', 1);

insert into book
values(seq_book_id.nextval, '토지', '마로니에북스', '15-aug-2012', 2);

insert into book
values(seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '01-apr-2015', 3);

insert into book
values(seq_book_id.nextval, '패션왕', '중앙북스(books)', '22-feb-2012', 4);

insert into book
values(seq_book_id.nextval, '순정만화', '재미주의', '03-aug-2011', 5);

insert into book
values(seq_book_id.nextval, '오직두사람', '문학동네', '04-may-2017', 6);

insert into book
values(seq_book_id.nextval, '26년', '재미주의', '04-feb-2012', 5);








update author
set author_desc = '서울특별시'
where author_id = 5;



delete from author
where author_id=4;
--삭제 안되는 이유.. 아마도 book의 5-패션왕 과 연결되어 있어서...??
--book_id 5를 먼저 지우고, 기안84데이터 지우면 지워짐

delete from book
where book_id=5;



