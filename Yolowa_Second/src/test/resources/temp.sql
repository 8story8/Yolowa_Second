create table y_board(
	bNo number primary key,
	bContent clob not null,
	bPostdate date not null,
	bType varchar2(100) not null,
	id varchar2(30) constraint fk_yboard_id references y_member
	ON DELETE CASCADE
);

select * from funding;
select m.* from(select * from contentlike where bNo = 85) cl, y_member m where m.id=cl.id
delete from Y_BOARD;
select likecount as countlike from contentlike where bNo =1 and id = 'bourbon'
select count(id) from PATICIPANT where bNo=85
select sum(fpoint) as totalpoint, count(id) as count from paticipant where bNo=85
create table board_opt(
   optNo number primary key,
    bNo number not null,
    local varchar2(100),
    filepath varchar2(100),
   constraint fk_board_bno foreign key(bNo) references y_board ON DELETE CASCADE
)
drop table board_opt;
create sequence seq_opt;

drop table contentlike;
create table contentlike(
	bNo number,
	id varchar2(30),
	constraint fk_contentid foreign key(id) references y_member ON DELETE CASCADE,
	constraint fk_contentno foreign key(bNo) references y_board ON DELETE CASCADE,
	constraint pk_contentlike primary key(id,bNo)
)


-- getAllBoardList
select bo.bNo, bo.bType,
     	bo.id, to_char(bo.bPostdate, 'YYYY/MM/DD HH24:MI') as bPostdate,
      	bo.bContent, bop.local, bop.filePath, c.countlike,
      	f.fTitle, f.fPoint, to_char(f.fDeadLine, 'YYYY/MM/DD HH24:MI') as fDeadLine, fPeople 
      	from Y_BOARD bo, BOARD_OPT bop, funding f, (select bNo, likeCount as countlike from
      	contentlike) c
      	where bop.bNo(+) = bo.bNo and f.bNo(+)=bo.bNo and c.bNo = bo.bNo order by bo.bNo desc

delete from Y_BOARD;

insert into Y_BOARD values(1, '오늘은 꺼져', sysdate, '문화', 'bourbon');
insert into BOARD_OPT values(1, 1, '미금역', 'Desert.jpg');
insert into CONTENTLIKE values(1, 'bourbon');

insert into Y_BOARD values(2, '내일 하루도 수고하세요!', sysdate, '문화', 'bourbon');
insert into BOARD_OPT values(2, 2, '서현역', 'Desert.jpg');
insert into CONTENTLIKE values(1, 'vermouth');

update CONTENTLIKE set likeCount = 2 where bNo = 1;
select * from Y_BOARD;
select * from BOARD_OPT;
select * from CONTENTLIKE

select bo.bType, bo.id, bo.bPostdate, bo.bContent, bop.local, bop.filePath, cl.countlike 
from (select count(*) as countlike from Y_BOARD tyb, CONTENTLIKE tcl where tyb.bNo = tcl.bNo) cl, Y_BOARD bo, BOARD_OPT bop

select * from Y_BOARD yb, BOARD_OPT bop, CONTENTLIKE cl

select * from Y_BOARD;
select * from BOARD_OPT;
select *  from Y_MEMBER;

select * from CONTENTLIKE;
insert into CONTENTLIKE values(54, 'bourbon');
delete from CONTENTLIKE;
select * from Y_BOARD;
update BOARD_OPT set local = '수원역' where local = '미금역';
insert into BOARD_OPT values(1, '강남역', '멍멍이');
insert into BOARD_OPT values(2, '잠실역', '고양이');
delete from BOARD_OPT where filepath = '멍멍이';

delete from y_board;

select count(*) from PATICIPANT where bNo=64 and id='java'

select bo.bNo, bo.bType,
     	bo.id, to_char(bo.bPostdate, 'YYYY/MM/DD HH24:MI') as bPostdate,
      	bo.bContent, bop.local, bop.filePath, c.countlike,
      	f.fTitle, f.fPoint, to_char(f.fDeadLine, 'YYYY/MM/DD HH24:MI') as fDeadLine, fPeople 
      	from Y_BOARD bo, BOARD_OPT bop, funding f, (select bNo, count(*) as countlike from
      	contentlike group by bNo) c
      	where bop.bNo(+) = bo.bNo and c.bNo(+)=bo.bNo and f.bNo(+)=bo.bNo and bo.bType='영화' order by bo.bNo desc
      	
select * from Y_member;
select * from Y_BOARD;
select * from CONTENTLIKE;
select * from interest;

select distinct bo.bNo, bo.bType,
     	bo.id, to_char(bo.bPostdate, 'YYYY/MM/DD HH24:MI') as bPostdate,
      	DBMS_LOB.SUBSTR(bo.bContent, 30000, 1) as bContent, bop.local, bop.filePath, c.countlike, f.fTitle
      	from Y_BOARD bo, BOARD_OPT bop, (select bNo, count(*) as countlike from
      	contentlike group by bNo) c, funding f, interest i
      	where bop.bNo(+) = bo.bNo and c.bNo(+) = bo.bNo and f.bNo(+)=bo.bNo and i.id='ipad' order by bo.bNo desc
      	
      	
      	select * from category;
      select * from interest where id = 'ipad';	
select distinct bo.bNo, bo.bType,
     	bo.id, to_char(bo.bPostdate, 'YYYY/MM/DD HH24:MI') as bPostdate,
      	DBMS_LOB.SUBSTR(bo.bContent, 30000, 1) as bContent, bop.local, bop.filePath, c.countlike, f.fTitle
      	from Y_BOARD bo, BOARD_OPT bop, (select bNo, count(*) as countlike from
      	contentlike group by bNo) c, funding f, interest i, category ct
      	where bop.bNo(+) = bo.bNo and c.bNo(+) = bo.bNo and f.bNo(+)=bo.bNo and bo.bType=ct.cType and i.cNo=ct.cNo and i.id='ipad' order by bo.bNo desc
      	
      	delete from Y_MEMBER;
      	delete from Y_Board;
      	
 drop table authorities;     	
      	create table authorities(
   username varchar2(100) not null,
   authority varchar(30) not null,
   constraint fk_authorities foreign key(username) references y_member(id) ON DELETE CASCADE,
   constraint member_authorities primary key(username,authority)
)

select * from Y_MEMBER
select count(*) from Y_MEMBER


select count(*) from Y_BOARD b, FUNDING f where f.bNo(+)=b.bNo and f.fTitle is null


		select bo.bNo, bo.bType,
     	bo.id, to_char(bo.bPostdate, 'YYYY/MM/DD HH24:MI') as bPostdate,
      	bo.bContent, bop.local, bop.filePath, c.countlike,
      	f.fTitle, f.fPoint, to_char(f.fDeadLine, 'YYYY/MM/DD HH24:MI') as fDeadLine, fPeople,p.totalpoint,p.count 
      	from Y_BOARD bo, BOARD_OPT bop, funding f, (select bNo, count(*) as countlike from contentlike group by bNo) c,(select bNo,sum(fpoint) as totalpoint, count(id) as count from paticipant group by bNo) p
      	where bop.bNo(+) = bo.bNo and f.bNo(+)=bo.bNo and c.bNo(+)= bo.bNo and p.bNo(+)= bo.bNo and bo.id='bourbon' order by bo.bNo desc
