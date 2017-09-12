drop table y_member;
drop table y_board;
drop table funding;
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
drop table category;
drop table interest;
drop table rank;


-- 쪽지 테이블 시퀀스
create sequence seq_message;
drop sequence seq_message

--카테고리 시퀀스
create sequence seq_category
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

-- log sequence 
create sequence seq_log;
drop sequence seq_log;

-- member table
create table y_member(
   id varchar2(30) primary key,
   password varchar2(100) not null,
   name varchar2(30) not null,
   address varchar2(100) not null,
   phone varchar2(100) not null,
   filepath varchar2(100) not null
)

select * from y_member
insert into y_member values('jdbc','1234','정우성','한남','010','string');
insert into y_member values('java','1234','임경수','구미','010','string');
insert into y_member values('spring','1234','아이유','판교','010','string');
insert into y_member values('javaking','1234','김경수','구미','010','resources/asset/img/ky.png')
insert into y_member values('lks','1234','박경수','구미','010','resources/asset/img/ky.png')
select * from Y_MEMBER;


--글쓰기파일업로드
insert into board_opt(bNo,filepath) values(2,'ssss');
select b.bno,b.bcontent,b.bpostdate,b.btype,b.id,o.local,o.filepath from Y_BOARD b, BOARD_OPT o where b.bno=o.bno
select * from Y_BOARD

-- board option table
create table board_opt(
   	optNo number primary key,
    bNo number not null,
    local varchar2(100),
    filepath varchar2(100),
   constraint fk_board_bno foreign key(bNo) references y_board ON DELETE CASCADE
)
select * from board_opt

drop table board_opt;
create sequence seq_opt;
insert into board_opt(optNo,bNo,filepath) values(seq_opt.nextval,1,'20');

update BOARD_OPT set bNo = '2' where bNo = '10';

select * from BOARD_OPT

create sequence seq_opt;
drop sequence seq_opt;

-- funding table
create table funding(
   fTitle varchar2(30) not null,
   fPoint number default 0,
   fDeadLine date not null,
   fPeople number default 0,
   bNo number constraint fk_board_no references y_board ON DELETE CASCADE,
   constraint pk_fund primary key(bNo)
)

select * from FUNDING

select bo.*, b.* from Y_BOARD b,board_opt bo where bo.bNo=b.bNo

select m.*,f.* from
(select bo.*, b.* from Y_BOARD b,board_opt bo where bo.bNo=b.bNo)m, FUNDING f 
where f.bno=m.bno
select * from Y_BOARD;
insert into b.*,bo.*,f.* from 
(select bo.*, b.* from Y_BOARD b,board_opt bo where bo.bNo=b.bNo)m, FUNDING f where f.bno=m.bno
where b.bNo=bo.bNo and b.bNo=f.bNo

insert all
	into y_board values(10,'안녕 아이폰 노주희 아이폰se',sysdate,'기타','java')
	into board_opt(bNo,local,filepath) values(10,'서현역','resources/asset/img/ky.png')
	into funding(fTitle,fDeadLine,bNo) values('test',sysdate,10)
where b.bNo=bo.bNo and b.bNo=f.bNo

-- funding table sequence
create sequence seq_funding;
drop sequence seq_funding;

-- paticipant table
create table paticipant(
   id varchar2(30),
   bNo number,
   fPoint number default 0,
   constraint fk_pid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bno foreign key(bNo) references funding ON DELETE CASCADE,
   constraint pk_funding primary key(id,bNo)
)

select sum(fpoint) as totalpoint , count(id) from paticipant where bNo=64
insert into PATICIPANT values('java',85,10);
insert into PATICIPANT values('spring',85,10);
select * from PATICIPANT where bNo=64

insert into PATICIPANT values('java',43,10,1);
insert into PATICIPANT values('spring',43,10,2);
select count(id) from PATICIPANT where bNo=64 and id='hate';

drop table paticipant

select * from paticipant;

-- like table
create table contentlike(
   bNo number,
   id varchar2(30),
   constraint fk_contentid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_contentno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_contentlike primary key(id,bNo)
)

create table message(
   mNo number primary key,
   rId varchar2(30) not null,
   sId varchar2(30) not null,
   message clob,
   mPostdate date not null,
   mCheck varchar2(30) default 'RN',
   constraint r_id foreign key(rId) references y_member(id) ON DELETE CASCADE,
    constraint s_id foreign key(sId) references y_member(id) ON DELETE CASCADE
);

-- bookmark table
create table bookmark(
   bNo number,
   id varchar2(30),
   constraint fk_bid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bookno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_bookmark primary key(id,bNo)
)

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
)


-- Log table
create table log(
   lNo number primary key,
   lContent clob not null,
   point number default 0,
   lDate date not null,
   id varchar2(30) constraint fk_log_id references y_member ON DELETE CASCADE
)
select * from log;

select lContent, point, to_char(lDate,'yyyy-mm-dd')as lDate from log where id = 'java' order by lDate desc;
select to_char(lDate,'yyyy-mm-dd')as lDate from (
select * from log where id='java' order by lNo desc) where rownum=1;
-- log sequence 
create sequence seq_log;
drop sequence seq_log;


----------------------------------------------------------------------

-- Point Table
create table point(
   id varchar2(30) primary key,
   point number not null,
   constraint p_id foreign key(id) references y_member(id) ON DELETE CASCADE
)


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


insert into category(cNo,cType) values(seq_category.nextval,'영화');
insert into category(cNo,cType) values(seq_category.nextval,'여행');
insert into category(cNo,cType) values(seq_category.nextval,'스포츠');
insert into category(cNo,cType) values(seq_category.nextval,'문화');
insert into category(cNo,cType) values(seq_category.nextval,'게임');
insert into category(cNo,cType) values(seq_category.nextval,'인테리어');
select * from category;

--관심테이블
create table interest(
   id varchar2(30),
   cNo number not null,
   primary key(id,cNo),
   constraint id foreign key(id) references y_member(id) ON DELETE CASCADE,
    constraint c_no foreign key(cNo) references category(cNo) ON DELETE CASCADE
)

-- rank table
drop table rank;
create table rank(
   keyword varchar2(100) primary key,
   count number default 1
)

-- board table
create table y_board(
   bNo number primary key,
   bContent clob not null,
   bPostdate date not null,
   bType varchar2(100) not null,
   id varchar2(30) constraint fk_yboard_id references y_member
   ON DELETE CASCADE
);

--글쓰기파일업로드
insert into Y_BOARD values(seq_yboard.nextval,'안녕 아이폰 노주희 아이폰se',sysdate,'기타','java');
insert into board_opt(bNo,filepath) values(2,'ssss');
select b.bno,b.bcontent,b.bpostdate,b.btype,b.id,o.local,o.filepath from Y_BOARD b, BOARD_OPT o where b.bno=o.bno
select * from Y_BOARD


-- board option table
create table board_opt(
    bNo number,
    local varchar2(100),
    filepath varchar2(100),
   constraint fk_board_bno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_board_opt primary key(bNo)
)

-- funding table
create table funding(
   fTitle varchar2(30) not null,
   fPoint number default 0,
   fDeadLine date not null,
   fPeople number default 0,
   bNo number constraint fk_board_no references y_board ON DELETE CASCADE,
   constraint pk_fund primary key(bNo)
)
alter table funding modify(fTitle varchar2(100))
drop table funding
insert into funding(fTitle,fDeadLine,bNo) values('test',sysdate,1)
insert into funding(fTitle,fDeadLine,bNo) values('test2',sysdate,2)
insert into funding(fTitle,fDeadLine,bNo) values('test3',sysdate,3);
insert into Y_BOARD values(1,'안녕 아이폰 노주희 아이폰se',sysdate,'기타','java');
select * from FUNDING


select bo.*, b.* from Y_BOARD b,board_opt bo where bo.bNo=b.bNo

select m.*,f.* from
(select bo.*, b.* from Y_BOARD b,board_opt bo where bo.bNo=b.bNo)m, FUNDING f 
where f.bno=m.bno

insert into b.*,bo.*,f.* from 
(select bo.*, b.* from Y_BOARD b,board_opt bo where bo.bNo=b.bNo)m, FUNDING f where f.bno=m.bno
where b.bNo=bo.bNo and b.bNo=f.bNo

insert all
	into y_board values(10,'안녕 아이폰 노주희 아이폰se',sysdate,'기타','java')
	into board_opt(bNo,local,filepath) values(10,'서현역','resources/asset/img/ky.png')
	into funding(fTitle,fDeadLine,bNo) values('test',sysdate,10)
where b.bNo=bo.bNo and b.bNo=f.bNo


select * from y_board
select * from board_opt
select * from funding
-- funding table sequence
create sequence seq_funding;
drop sequence seq_funding;
-- paticipant table
create table paticipant(
   id varchar2(30),
   bNo number,
   fPoint number default 0,
   constraint fk_pid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bno foreign key(bNo) references funding ON DELETE CASCADE,
   constraint pk_funding primary key(id,bNo)
)
select * from contentlike

-- like table
create table contentlike(
   bNo number,
   id varchar2(30),
   constraint fk_contentid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_contentno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_contentlike primary key(id,bNo)
)
insert into contentlike values(1,'java');
insert into contentlike values(1,'javaking');
delete CONTENTLIKE where id='java';

select * from contentlike;

-- bookmark table
create table bookmark(
   bNo number,
   id varchar2(30),
   constraint fk_bid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bookno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_bookmark primary key(id,bNo)
)
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
)
-- reply sequence table
create sequence seq_reply;
drop sequence seq_reply;
-- Log table
create table log(
   lNo number primary key,
   lContent clob not null,
   point number default 0,
   lDate date not null,
   id varchar2(30) constraint fk_log_id references y_member ON DELETE CASCADE
)
select * from log;
-- log sequence 
create sequence seq_log;
drop sequence seq_log;

insert into log values(seq_log.nextval,'로그인 포인트',50,to_date(sysdate),'java');
select to_char(lDate,'yyyy-mm-dd') from log where id='java';

`
-- Point Table
create table point(
   id varchar2(30) primary key,
   point number not null,
   constraint p_id foreign key(id) references y_member(id) ON DELETE CASCADE
)
select * from point;

--Grade Table
create table grade(
   gNo number primary key,
   grade varchar2(100) not null,
   lowpoint number default 0,
   highpoint number default 0
);

insert into grade values(seq_grade.nextval,'정회원',0,500);
insert into grade values(seq_grade.nextval,'우수회원',501,10000);
create sequence seq_grade;
drop sequence seq_grade;
drop table grade
-- 친구 테이블
create table follow(
   sendId varchar2(30),
   receiveId varchar2(30),
   fcheck varchar2(30) default 'false',
   primary key(sendId,receiveId),
   constraint f_sid foreign key(sendId) references y_member(id) ON DELETE CASCADE,
    constraint f_rid foreign key(receiveId) references y_member(id) ON DELETE CASCADE
);
select * from follow 
insert into follow(sendId,receiveId) values('java','javaking');
insert into follow(sendId,receiveId) values('java','spring');

insert into follow(sendId,receiveId) values('javaking','lks');



select id,password,name,address,phone,filepath from (
select receiveId from follow where sendId='java' and fcheck='true') F, y_member m where m.id = F.receiveId
   
select * from follow where sendId='java'
   
update follow set fcheck = 'true' where sendId = 'java';
select * from interest where id='java'
--메세지 테이블 삭제
drop table message;

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
update message set fcheck = 'SM' where  
drop table message

insert into message(mNo,sId,rId,message,mPostdate) values(seq_message.nextval,'javaking','java','하잉',sysdate);

select * from message;
select * from message where rId='java';
-- 쪽지 테이블 시퀀스
create sequence seq_message;
drop sequence seq_message

create table category(
   cNo number primary key,
   cType varchar2(100) not null
);

create sequence seq_category
drop sequence seq_category
insert into category(cNo,cType) values(seq_category.nextval,'영화');
insert into category(cNo,cType) values(seq_category.nextval,'여행');
insert into category(cNo,cType) values(seq_category.nextval,'스포츠');
insert into category(cNo,cType) values(seq_category.nextval,'문화');
insert into category(cNo,cType) values(seq_category.nextval,'게임');
insert into category(cNo,cType) values(seq_category.nextval,'인테리어');
select * from category;

create table interest(
   id varchar2(30),
   cNo number not null,
   primary key(id,cNo),
   constraint id foreign key(id) references y_member(id) ON DELETE CASCADE,
    constraint c_no foreign key(cNo) references category(cNo) ON DELETE CASCADE
)
select * from Y_MEMBER
select * from interest;
insert into interest(id,cNo) values('jdbc',1);
insert into interest(id,cNo) values('jdbc',2);
insert into interest(id,cNo) values('jdbc',3);
select i.cNo from interest i, category c where i.id='java' and i.cNo=c.cNo;


-- rank table
drop table rank;
create table rank(
   keyword varchar2(100) primary key,
   count number default 1
)
insert into rank values('여행',5);
insert into rank values('자전거',3);
insert into rank values('사진',2);
insert into rank values('영화',2);
insert into rank values('아이폰',1);
select ranking, keyword, count
from(select keyword, count, rank() over(order by count desc) as ranking from rank)
where ranking <= 5

select * from rank;

select * from follow

select * from y_member
select * from y_member m, interest i where i.cNo=1 or i.cNo=2 and  m.id=i.id

select * from category
select * from interest
select * from y_member m, interest i where  m.id=i.id and i.cNo =1 
select * from y_member m, interest i where  m.id=i.id and i.cNo =1 and i.cNo = 2

select * from y_member where  id=(select distinct id from interest where cNo =1 or cNo=2)



select m.id from(select distinct id from interest where  cNo=1)A, y_member m where A.id=m.id


select distinct id from interest where cNo =1 or cNo=2

select * from interest

select cNo from interest where id = 'jdbc'

select ename from emp 
where empno =
(select mgr from emp 
where  sal =(select min(sal) from emp))
select m.id from y_member m, interest i where i.cNo=1 and m.id=i.id;
select * from y_member m, interest i where i.cNo=1 and m.id=i.id;

select * from point;
insert into point(id,point) values('java',50);
insert into point(id,point) values('javaking',100);
insert into point(id,point) values('spring',100);
insert into point(id,point) values('lks',100);
insert into point(id,point) values('jdbc',100);
insert into point(id,point) values('jdbc',100);
insert into point(id,point) values('jquery',100);
update point set point=point+50 where id='java';
select m.id,m.password,m.name,m.address,m.phone,m.filepath,p.point 
from point p, y_member m 
where m.id=p.id(+) and m.id='jquery';
select sendId from follow where receiveId='javaking' and fcheck='false';
select * from follow where sendId='javaking' and receiveId='java'
select * from y_member where name='한효주';
select * from follow;
delete from follow where sendId='java' and receiveId='jdbc' or sendId='jdbc' and receiveId='java';
select * from(select * from follow
where sendId='javaking' or receiveId='javaking')f where f.fcheck='false'

insert into follow values('java','lks','false')
insert into follow(sendId,receiveId) values('java', 'spring');

select distinct m.*,f.* from y_member m, follow f where m.id !='java';
select distinct m.*,f.* from y_member m, follow f where m.id=f.sendId or m.id=f.receiveId and m.id !='java';



select m.* from(select distinct id from interest i where cNo=1)A, y_member m  where m.id=A.id 

select bo.bNo, bo.bType,
     	bo.id, to_char(bo.bPostdate, 'YYYY/MM/DD HH24:MI') as bPostdate,
      	bo.bContent, bop.local, bop.filePath, c.countlike,
      	f.fTitle, f.fPoint, to_char(f.fDeadLine, 'YYYY/MM/DD HH24:MI') as fDeadLine, fPeople 
      	from Y_BOARD bo, BOARD_OPT bop, funding f, (select bNo, count(*) as countlike from
      	contentlike group by bNo) c
      	where bop.bNo(+) = bo.bNo and f.bNo(+)=bo.bNo and c.bNo(+)= bo.bNo order by bo.bNo desc


select m.* from(select distinct id from interest 
where cNo=1)A, y_member m where m.id=A.id and m.id !='java';
select fcheck from follow where sendId='java';
select * from follow where sendId='spring';
select name from y_member where id='jdbc';

select * from message where sId='java' and rId = 'javaking' or sId='javaking' and rId='java' order by mPostdate desc 


select * from y_member m, point p, interest i where m.id=p.id and m.id=i.id

 select m.id from (select distinct sId from message where  rId='java')M, y_member m where m.id=M.sId
 
 select count(*) from message where rId='java'
 
 
 select A.mNo,A.rId,A.sId,A.message,A.mPostdate,A.mCheck from(select row_number() over(order by mNo desc)as
		rnum, mNo,rId,
		sId,message,mPostdate,mCheck from message where rId='java')A
		where rnum between 1 and 5

select * from interest 

select * from message;
select m.* from(select distinct id from interest where cNo=1 or cNo=2)A, y_member m where m.id=A.id and m.id !='java'

select * from follow


select id,password,name,address,phone,filepath from (select * from 
follow where sendId='java' or receiveId='javaking' and fcheck='true') F, y_member m where m.id !='javaking'
		
select * from follow
select * from interest
		
select id,password,name,address,phone,filepath from(select * from(select * from
follow where sendId='javaking'or receiveId='javaking')f  where
		
select * from(select * from
follow where sendId='spring'or receiveId='spring')f where f.fcheck='true'
		
select * from(select * from
follow where sendId='java'and receiveId='javaking' or sendId='javaking' and receiveId='java')f 
		
select * from follow
select id,password,name,address,phone,filepath from (select receiveId from
follow where sendId=#{value} and fcheck='true') F, y_member m
where m.id = F.receiveId
		
select m.* from(select distinct id from interest where cNo=1)A, y_member m where m.id=A.id and m.id !='java'
			
			
select * from Y_Member;
select f.* from(select * from
follow where sendId='java' or receiveId='java')f, y_member m where f.fcheck='true' and m.id='java'
			
		
select m.* from(select distinct id from interest where cNo=1)A, y_member m where m.id=A.id and m.id != 'java'
		
select * from(select * from follow where sendId='java' or receiveId='java')

update message set mCheck='RN' where sId='java' or rId='java'
select * from message where rId='java';
select count(*) from(select * from message where mCheck='RD' or mCheck='SD')M where sId='java' or rId='java'


select A.mNo,A.rId,A.sId,A.message,A.mPostdate,A.mCheck from(select
		row_number() over(order by mNo desc)as rnum,
		M.mNo,M.rId,M.sId,M.message,M.mPostdate,M.mCheck from
		(select * from message where mCheck='RD' or mCheck='SD')M where M.sId='java'  or M.rId='java')A
		where rnum
		between 1 and 5

select M.* from(select * from message where mCheck='RD' or mCheck='SD')M where sId='java' or rId='java'
select * from message where mNo=1 and rId='java';

select * from message

update message set mCheck='SD' where mNo=1 and sId='java';
delete from message where mNo=1;


select * from(select * from follow where sendId='java' or receiveId='java')f

select * from CONTENTLIKE;
select likecount as countlike from contentlike where bNo = #{bNo} and id = #{id}

select * from Y_BOARD;
insert into contentlike values(1,'jdbc');
insert into contentlike values(1,'bourbon');
select m.* from (select * from contentlike where bNo = 1) cl, y_member m where m.id=cl.id;

select * from Y_BOARD
select * from BOARD_OPT
select * from FUNDING
update Y_BOARD y,BOARD_OPT b, FUNDING f
set y.bcontent='234', y.btype='234', b.local='234', b.filepath='234', f.ftitle='234', f.fpoint=1, f.fpeople=1
where y.bno=b.bno=f.bno=4;

select count(*) from y_member where password='1234';
<<<<<<< HEAD

<<<<<<< HEAD
create table authorities(
   username varchar2(100) not null,
   authority varchar(30) not null,
   constraint fk_authorities foreign key(username) references y_member(id),
   constraint member_authorities primary key(username,authority)
)

delete from Y_Member;
delete from Y_Board;
delete from authorities;
=======
=======

select * from y_member;
delete from y_member where id='java';
>>>>>>> branch 'master' of https://github.com/limkyoungsoo/yolowa_second.git

select * from y_member  where id='rudtn0709'

select * from point;
select m.id,m.password,m.name,m.address,m.phone,m.filepath,p.point,g.grade
		from point p, y_member m, grade g where p.id=m.id and m.id='rudtn0709' and p.point > g.lowpoint and p.point < g.highpoint
		
select * from grade

update point set point=point+500 where id='rudtn0709'
<<<<<<< HEAD
update message set
		mCheck='RM' where sId='test' and rId='test1'
		
		select * from message
=======
<<<<<<< HEAD
>>>>>>> branch 'master' of https://github.com/limkyoungsoo/yolowa_second.git
drop table grade;
create table grade(
   gNo number primary key,
   grade varchar2(100) not null,
   lowpoint number default 0,
   highpoint number default 0
);

insert into grade values(seq_grade.nextval,'정회원',0,500);
insert into grade values(seq_grade.nextval,'우수회원',501,10000);
create sequence seq_grade;
=======

>>>>>>> branch 'master' of https://github.com/limkyoungsoo/yolowa_second.git
>>>>>>> branch 'master' of https://github.com/limkyoungsoo/yolowa_second.git

select * from message where sId='test'
select count(*) from message where sId='test' and mCheck !='SD'