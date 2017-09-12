drop table y_member;
drop table board_opt;
drop table reply;
drop table bookmark;
drop table contentlike;
drop table paticipant;
drop table log;
drop table point;
drop table grade;
drop table follow;
drop table message;
drop table interest;
drop table rank;
drop table funding;
drop table category;
drop table y_board;
drop table authorities;


-- 쪽지 테이블 시퀀스
create sequence seq_message;
drop sequence seq_message

--카테고리 시퀀스
create sequence seq_category;
drop sequence seq_category

-- board table sequence
create sequence seq_yboard;
drop sequence seq_yboard;


--board 옵션 시퀀스
create sequence seq_opt;
drop sequence seq_opt;

-- funding table sequence
create sequence seq_funding;
drop sequence seq_funding;

-- reply sequence table
create sequence seq_reply;
drop sequence seq_reply;
create sequence seq_reply_group;
drop sequence seq_reply_group;

-- board_opt sequence table
create sequence seq_opt;
drop sequence seq_opt;

-- log sequence 
create sequence seq_log;
drop sequence seq_log;

--grade sequence
create sequence seq_grade;
drop sequence seq_grade;


-- member table
create table y_member(
   id varchar2(30) primary key,
   password varchar2(100) not null,
   name varchar2(30) not null,
   address varchar2(100) not null,
   phone varchar2(100) not null,
   filepath varchar2(100) not null
);

-- board table
create table y_board(
   bNo number primary key,
   bContent clob not null,
   bPostdate date not null,
   bType varchar2(100) not null,
   id varchar2(30) constraint fk_yboard_id references y_member
   ON DELETE CASCADE
);

-- funding table
create table funding(
   fTitle varchar2(30) not null,
   fPoint number default 0,
   fDeadLine date not null,
   fPeople number default 0,
   bNo number constraint fk_board_no references y_board ON DELETE CASCADE,
   constraint pk_fund primary key(bNo)
);
commit
-- paticipant table
create table paticipant(
   id varchar2(30),
   bNo number,
   fPoint number default 0,
   constraint fk_pid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bno foreign key(bNo) references funding ON DELETE CASCADE,
   constraint pk_funding primary key(id,bNo)
);

-- like table
create table contentlike(
   bNo number,
   id varchar2(30),
   constraint fk_contentid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_contentno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_contentlike primary key(id,bNo)
);

-- bookmark table
create table bookmark(
   bNo number,
   id varchar2(30),
   constraint fk_bid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bookno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_bookmark primary key(id,bNo)
);




-- Log table
create table log(
   lNo number primary key,
   lContent clob not null,
   point number default 0,
   lDate date not null,
   id varchar2(30) constraint fk_log_id references y_member ON DELETE CASCADE
);

-- Point Table
create table point(
   id varchar2(30) primary key,
   point number not null,
   constraint p_id foreign key(id) references y_member(id) ON DELETE CASCADE
);


-- 친구 테이블
create table follow(
   sendId varchar2(30),
   receiveId varchar2(30),
   fcheck varchar2(30) default 'false',
   primary key(sendId,receiveId),
   constraint f_sid foreign key(sendId) references y_member(id) ON DELETE CASCADE,
    constraint f_rid foreign key(receiveId) references y_member(id) ON DELETE CASCADE
);

-- 메세지 테이블
create table message(
   mNo number primary key,
   rId varchar2(30) not null,
   sId varchar2(30) not null,
   message clob,
   mPostdate date not null,
   mCheck varchar2(30) default 'SM',
   constraint r_id foreign key(rId) references y_member(id) ON DELETE CASCADE,
    constraint s_id foreign key(sId) references y_member(id) ON DELETE CASCADE
);

--카테고리 테이블
create table category(
   cNo number primary key,
   cType varchar2(100) not null
);



--관심테이블
create table interest(
   id varchar2(30),
   cNo number not null,
   primary key(id,cNo),
   constraint id foreign key(id) references y_member(id) ON DELETE CASCADE,
    constraint c_no foreign key(cNo) references category(cNo) ON DELETE CASCADE
);

-- rank table
create table rank(
   keyword varchar2(100) primary key,
   count number default 1
);



-- board option table
create table board_opt(
      optNo number primary key,
    bNo number not null,
    local varchar2(100),
    filepath varchar2(100),
   constraint fk_board_bno foreign key(bNo) references y_board ON DELETE CASCADE
);

-- funding table
create table funding(
   fTitle varchar2(30) not null,
   fPoint number default 0,
   fDeadLine date not null,
   fPeople number default 0,
   bNo number constraint fk_board_no references y_board ON DELETE CASCADE,
   constraint pk_fund primary key(bNo)
);

-- reply table
create table reply(
   rNo number primary key,
   rContent clob not null,
   groupNo number not null,
   parentsNo number not null,
   depth number not null,
   rOrder number not null,
   id varchar2(30) constraint fk_reply_id references y_member ON DELETE CASCADE,
   bNo number constraint fk_reply_bno references y_board ON DELETE CASCADE
);

--Grade Table
create table grade(
   gNo number primary key,
   grade varchar2(100) not null,
   lowpoint number default 0,
   highpoint number default 0
);

--Spring Security
create table authorities(
   username varchar2(100) not null,
   authority varchar(30) not null,
   constraint fk_authorities foreign key(username) references y_member(id) ON DELETE CASCADE,
   constraint member_authorities primary key(username,authority)
);
--로그인 보안 table
create table authorities(
   username varchar2(100) not null,
   authority varchar(30) not null,
   constraint fk_authorities foreign key(username) references y_member(id),
   constraint member_authorities primary key(username,authority)
);

--카테고리목록
insert into category(cNo,cType) values(seq_category.nextval,'영화');
insert into category(cNo,cType) values(seq_category.nextval,'여행');
insert into category(cNo,cType) values(seq_category.nextval,'스포츠');
insert into category(cNo,cType) values(seq_category.nextval,'도서');
insert into category(cNo,cType) values(seq_category.nextval,'게임');
insert into category(cNo,cType) values(seq_category.nextval,'인테리어');

--회원가입
select * from y_member
insert into y_member values('jdbc','1234','정우성','한남','010','string');
insert into y_member values('java','1234','임경수','구미','010','string');
insert into y_member values('spring','1234','아이유','판교','010','string');
insert into y_member values('javaking','1234','김경수','구미','010','resources/asset/img/ky.png')
insert into y_member values('lks','1234','박경수','구미','010','resources/asset/img/ky.png')
select * from Y_MEMBER;

--등급 기준
insert into grade values(seq_grade.nextval,'정회원',0,500);
insert into grade values(seq_grade.nextval,'우수회원',501,10000);
--등급 상승
update POINT set point=5000 where id='yolowa';

--글쓰기파일업로드
insert into Y_BOARD values(1,'안녕 디지몬 내꿈을 향해 달리기',sysdate,'여행','java');
insert into board_opt(optno,bNo,local,filepath) values(1,1,'판교','co.jpg/SpringMVC.jpg');
insert into Y_BOARD values(2,'수박먹기대회 참가 인증샷',sysdate,'여행','java');
insert into board_opt(optno,bNo,local,filepath) values(2,2,'강릉','이성경.jpg');
insert into Y_BOARD values(3,'재미있는 아스팔트',sysdate,'스포츠','java');
insert into board_opt(optno,bNo,local,filepath) values(3,3,'서울역','아스팔트.jpg/상디.jpg');
insert into Y_BOARD values(4,'즐거운 스포츠',sysdate,'스포츠','java');
insert into board_opt(optno,bNo,local,filepath) values(4,4,'김포','스포츠.jpg');
insert into Y_BOARD values(5,'안녕 안녕 친구들',sysdate,'게임','java');
insert into board_opt(optno,bNo,local,filepath) values(5,5,'신림역','루피어린이.jpg');
insert into Y_BOARD values(6,'안녕 옵치충들',sysdate,'게임','java');
insert into board_opt(optno,bNo,local,filepath) values(6,6,'판교','오버워치.jpg');

insert into Y_BOARD values(8,'안녕 옵치충들',sysdate,'게임','java');
insert into FUNDING values('옵치충들모여라,컴퓨터 공구하러가자~',100,'2017-09-21',10,8);
insert into board_opt values(8,8,'판교','오버워치.jpg');

insert into Y_BOARD values(9,'안녕 피규어사러가자',sysdate,'인테리어','java');
insert into FUNDING values('피규어사러가자',100,'2017-09-21',10,9);
insert into board_opt values(9,9,'판교','상디어린이.jpg/루피어린이.jpg');

insert into Y_BOARD values(10,'hello wold',sysdate,'여행','java');
insert into FUNDING values('호날두 사러갑시다',1000000,'2017-09-22',1000,10);
insert into board_opt values(10,10,'김포공항','호날두.jpg/호날두2.jpg');

insert into Y_BOARD values(11,'자전거타러 가실분,
출발지:판교역,도착지:부산역
두번째 사진은 짤방용',sysdate,'여행','java');
insert into FUNDING values('자전거여행',100,'2017-09-24',10,11);
insert into board_opt values(11,11,'판교','자전거2.jpg/정소민.jpg');

--글쓰기파일업로드
select b.bno,b.bcontent,b.bpostdate,b.btype,b.id,o.local,o.filepath from Y_BOARD b, BOARD_OPT o where b.bno=o.bno
select * from Y_BOARD


