drop table booking;
drop table customer;
drop table batch;
drop table Tour;

Create table Tour (Tour_ID number(3) primary key, 
tour_name varchar2(25) not null, 
no_of_days number(2),
tour_cost number(10,2), 
itinerary varchar2(200));

Create table batch (batch_id char(10) primary key,
tour_id number(3) references tour (tour_id) on delete cascade, no_of_seats number(3), 
no_of_seats_booked number(3), start_date date, batch_coordinator varchar2(30));

Create table customer (cust_id number(7) primary key, 
cust_name varchar2(30), 
cust_address varchar2(50), 
cust_age number(3), 
cust_sex char(1) check(cust_sex in('f','m')));

Create table booking (cust_id number(7) references customer(cust_id), 
batch_id char(10) references batch(batch_id), 
seat_alloted number(3), booking_date date, 
balance_pay number(10,2));

Insert into tour values (1, 'dom-dlx-kashmir', 8, 20000.00, 'mumbai(1)-sri nagar(1,2)-pahelgaum(3,4)-gulmarg(5)-sonmarg(6)-vaishnodevi(7,8)-Jammu(8)-Mumbai');
Insert into tour values (2, 'dom-ndl-bang/mys/ooty', 9, 13000.00, 'mumbai(1)-banglore(2,3,4)-mysore(5,6)-ooty(7,8)-Mumbai');
Insert into tour values (3, 'int-grnd-Europe',13, 120000.00, 'mumbai(1)-UK(2,3,4,5)-Switz(6,7,8)-Zurich(9,10,11,12)-Mumbai');
Insert into tour values (4, 'int-dlx-Singapore',10, 60000.00, 'mumbai(1)-singapore(2,3,4)-bankok(5,6,7)-pattaya(8,9)-Mumbai');
Insert into tour values (5, 'dom-ndl-Kerala',9, 10000.00, 'mumbai(1)-trivendrum(2,3)-munnar(5,6)-allepy(7)-Cochin(8)-Mumbai');
Insert into tour values (6, 'dom-dlx-Shimala,Manali',10, 20000.00, 'mumbai(1)-Chandigarh(2)-Manali(5,6,7)-Shimala(8,9)-Mumbai');
Insert into tour values (7, 'dom-dlx-Delhi', 8, 20000.00, 'mumbai(1)-chandigarh(1,2)-Agra(3,4)-Delhi(5,6,7)-Mumbai');

Insert into batch values('2008-0120',1,45,43,sysdate,'Suyog');
Insert into batch values('2018-0127',2,150,140,sysdate-30,'Reena');
Insert into batch values('2018-0178',3,50,48,sysdate-15,'Arjun');
Insert into batch values('2018-0305',5,125,122,sysdate+20,'Avaneesh');
Insert into batch values('2018-0320',6,75,72,sysdate+5,'Ramesh');
Insert into batch values('2018-0411',1,50,42,sysdate,'Suyog');
Insert into batch values('2018-0486',6,50,38,sysdate-11,'Ramesh');
Insert into batch values('2018-0555',4,50,31,sysdate+10,'Arjun');
Insert into batch values('2018-0594',3,50,22,sysdate+3,'Arjun');
Insert into batch values('2018-0645',2,50,20,sysdate+50,'Reena');

Insert into customer values(1001,'Rakesh Shukla','Vile Parle (E), Mumbai',52,'m');
Insert into customer values(1002,'Amit Kumar Singh','Powai , Mumbai',27,'m');
Insert into customer values(1003,'Neepa Shah','Goregaon (W), Mumbai',28,'f');
Insert into customer values(1004,'Amrish Agarwal','Lower Parel, Mumbai',42,'m');
Insert into customer values(1005,'Anand Rathi','Vile Parle (W), Mumbai',61,'m');
Insert into customer values(1006,'Geeta Karla','Jogeshwari (E), Mumbai',57,'f');
Insert into customer values(1007,'Nimesh Bhagat','Matunga (C), Mumbai',37,'m');
Insert into customer values(1008,'Avinash Limaye','Dadar (W), Mumbai',41,'m');
Insert into customer values(1009,'Ritesh Kulkarni','Bhuleshwar, Mumbai',54,'m');
Insert into customer values(1010,'Rajashri Puri','Mulund (E), Mumbai',47,'f');
 

 
insert into booking values(1001, '2008-0120',1,sysdate-30,5000);
insert into booking values(1002, '2008-0120',2,sysdate-30,7000);
insert into booking values(1008, '2018-0127',1,sysdate-60,1000);
insert into booking values(1004, '2018-0127',2,sysdate-60,3000);
insert into booking values(1010, '2018-0178',1,sysdate-45,50000);
insert into booking values(1009, '2018-0305',1,sysdate-20,3000);
insert into booking values(1007, '2018-0320',1,sysdate-40,7000);
insert into booking values(1003, '2018-0411',5,sysdate-25,4000);
insert into booking values(1010, '2018-0411',6,sysdate-24,6000);
insert into booking values(1009, '2018-0555',1,sysdate-50,60000);
insert into booking values(1004, '2018-0594',1,sysdate-30,40000);
insert into booking values(1001, '2018-0594',5,sysdate,50000);


commit;


select * from tour;
select * from batch;
select * from booking;
select * from customer;
ans 1)
select to_char(start_date,'Month'),count(batch_id) from batch where tour_id=1 and to_char(start_date,'mm')=to_char(sysdate,'mm') 
group by start_date;


ans 2)
select
c.cust_name,ba.batch_id,ba.tour_id,bo.booking_date,bo.balance_pay
from
customer c,batch ba,booking bo
where cust_id in(select cust_id from customer where cust_address like 'Vile%');


3
select cust_id,cust_name,count(batch_id),sum(balance_pay)
from booking group by cust_id,cust_name;


4

5
select tour_id,tour_name,no_of_days,tour_cost,itinerary from tour 
where tour_name like 'dom%';

6 (incomplete)
select b.batch_id,t.tour_id,(no_of_days) as "remark"
case remark
when (sysdate>remark) then 'Tour Completed'
when(sysdate<remark) then 'on the tour'
else 'will be leaving soon' END
from tour t,batch b
where t.tour_id=b.tour_id;

7

 
 select tour.tour_name, nvl(to_char(batch_id),'null') from tour ,batch 
 where batch.tour_id(+)=tour.tour_id;
 
8

SELECT cust_id
FROM booking
WHERE batch_id IN
  (SELECT batch_id
  FROM batch
  WHERE tour_id IN (select tour_id from
     tour WHERE tour_cost>=
      (SELECT MAX(tour_cost) FROM tour
      )
    ));
9

select tour_id,tour_name from tour where tour_id not in(select tour_id from batch);

10
create view vw_batch_tour
as select 
ba.batch_id,
t.no_of_days,
ba.start_date,
bo.seat_alloted
from
batch ba, tour t, booking bo
where 
ba.tour_id=t.tour_id
and ba.batch_id=bo.batch_id
order by start_date;


11
insert into batch values('2009-0120',6,24,56,'06-08-18','suyog');

select * from tour;
select * from batch;
select * from booking;
select * from customer;






ans.1

select to_char(start_date,'Month'),count(batch_id) from batch where tour_id=1 and to_char(start_date,'mm')=to_char(sysdate,'mm') 
group by start_date;





ans . 4
select t.tour_id,t.tour_name
from customer c,tour t
where c.cust_id IN
(select cust_id from booking bo,batch b, tour t
where bo.batch_id=b.batch_id
and b.tour_id =t.tour_id
and ((bo.balance_pay/t.tour_cost)*100)>50);
ans.5

select tour_id,tour_name,no_of_days,tour_cost,itinerary from tour 
where tour_name like 'dom%';

ans.6

select b.batch_id,t.tour_id,(t.no_of_days+b.start_date) as "remark"
case remark
when (sysdate>remark) then 'Tour Completed'
when(sysdate<remark) then 'on the tour'
else 'will be leaving soon' END
from tour t,batch b
where t.tour_id=b.tour_id;

ans.7

select tour.tour_name, nvl(to_char(batch_id),'null') from tour ,batch 
where batch.tour_id(+)=tour.tour_id;
 
ans.8 

SELECT cust_id
FROM booking
WHERE batch_id IN
  (SELECT batch_id
  FROM batch
  WHERE tour_id IN (select tour_id from
     tour WHERE tour_cost>=
      (SELECT MAX(tour_cost) FROM tour
      )
    ));

ans.9

select tour_id,tour_name from tour where tour_id not in(select tour_id from batch);

ans.10

create view vw_batch_tour
as select 
ba.batch_id,
t.no_of_days,
ba.start_date,
bo.seat_alloted
from
batch ba, tour t, booking bo
where 
ba.tour_id=t.tour_id
and ba.batch_id=bo.batch_id
order by start_date;


ans.11

insert into batch values('2009-0120',6,24,56,'06-08-18','suyog');