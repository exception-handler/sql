select * from ACCOUNT_DETAIL;
SELECT * FROM BANK_DETAIL;
SELECT * FROM COUNTRIES;
SELECT * FROM CUSTOMER_DETAIL;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;
SELECT * FROM TRANSACTION_DETAIL;

--practise
--ass 
--Q18

--Q19
select first_name ,hire_date ,trunc(sysdate-hire_date) as "days",
trunc((sysdate-hire_date)/7) as "weeks" ,trunc((trunc(months_between(sysdate,hire_date)))/12) as "years"
from EMPLOYEES;
--Q20
select to_char(hire_date,'fmYear,Month,dd,day') from employees;
--Q21
select location_id,INITCAP(substr(street_address,1,20)) from LOCATIONS; 
--Q22
select last_name,salary,RPAD(LPAD(SALARY,10,'*'),15,'*') from EMPLOYEES;
--Q23
select first_name ,salary,commission_pct ,nvl(to_char(COMMISSION_PCT),
'EMPLOYEE EARNED NO COMMISSION') from EMPLOYEES;
--Q24
select first_name,salary,commission_pct ,nullif(commission_pct,.1) from EMPLOYEES;
--Q25
select first_name, department_id,
CASE department_id WHEN 50 THEN 'HR TEAM'
                  WHEN 80 THEN 'TRAINING TEAM'
                  ELSE 'Development Team' END
                  "RESULT"
from EMPLOYEES;
--Q26
--decode
--Q27
select c.CUSTOMER_NAME,substr(customer_name,1,INSTR(customer_name,' ',1,1)-1) as first_name ,
substr(customer_name,instr(customer_name,' ',-1,1)+1,length(customer_name)) as last_name,
b.branch_location,a.account_type,a.deposit_amount
from CUSTOMER_DETAIL c, BANK_DETAIL b,ACCOUNT_DETAIL a where
c.CUSTOMER_ID=a.CUSTOMER_ID and b.BRANCH_ID=a.BRANCH_ID and a.DEPOSIT_AMOUNT>5000;

--Q28
select a.account_id ,c.customer_name,c.customer_id 
from CUSTOMER_DETAIL c, ACCOUNT_DETAIL a where
a.CUSTOMER_ID(+)=c.CUSTOMER_ID;
--Q29
select e.employee_id,e.first_name,e.salary,m.salary as manager_salary
,(m.salary-e.salary) as difference from EMPLOYEES e,EMPLOYEES m where
e.manager_id=m.EMPLOYEE_ID;
--Q30
select e.employee_id,e.first_name||' '||last_name as name ,e.salary,d.department_name,
l.city,l.postal_code from EMPLOYEES e,DEPARTMENTS d,LOCATIONS l where e.DEPARTMENT_ID=d.DEPARTMENT_ID
and d.LOCATION_ID=l.LOCATION_ID and e.SALARY>5000;
--Q31
select count( distinct customer_id) as "no_of_account_opened_in_2010"
from ACCOUNT_DETAIL where to_char(acc_open_date,'yy')='10';

--Q32 who have atleast 2 accounts  (doubt) do it again later
select customer_name from CUSTOMER_DETAIL where CUSTOMER_ID IN
(select CUSTOMER_ID from ACCOUNT_DETAIL group by CUSTOMER_ID having count(account_id)>1);


--Q33
select * from ACCOUNT_DETAIL;
select * from CUSTOMER_DETAIL;
select customer_id , count(branch_id) from ACCOUNT_DETAIL group by customer_id;

--Q34
select c.customer_name, c.customer_address ,count(a.branch_id) from CUSTOMER_DETAIL c,ACCOUNT_DETAIL a 
where c.CUSTOMER_ID = a.CUSTOMER_ID group by c.CUSTOMER_ADDRESS,c.CUSTOMER_NAME,a.CUSTOMER_ID ;

--Q35
select * from transaction_detail;
select * from CUSTOMER_DETAIL;
select * from ACCOUNT_DETAIL;

select customer_name,transaction_type,count(account_id)
from CUSTOMER_DETAIL natural join ACCOUNT_DETAIL
NATURAL JOIN TRANSACTION_DETAIL group by
customer_name,transaction_type;

--Q36 doubt
select customer_name , (COUNT(account_id))
from CUSTOMER_DETAIL natural join account_detail
natural join TRANSACTION_DETAIL group by customer_name
having count(account_id)=
(select max(count(account_id)) from CUSTOMER_DETAIL natural join
ACCOUNT_DETAIL natural join TRANSACTION_DETAIL group by customer_name);
--extra stuff
select account_id,count(transaction_id) from TRANSACTION_DETAIL group by account_id ;
select max(count(transaction_id)) from transaction_detail group by account_id;
select * from TRANSACTION_DETAIL;
select * from ACCOUNT_DETAIL;
select * from CUSTOMER_DETAIL;
--or
select ct.customer_name, count(*)as countoftrans
from account_detail att,customer_detail ct,transaction_detail t
where att.account_id=t.account_id and ct.customer_id=att.customer_id
group by ct.customer_name,t.account_id
having count(*)=(select max(count(*)) from transaction_detail group by account_id);

--Q37
select customer_id ,account_id from account_detail group by CUSTOMER_ID,ACCOUNT_ID order by CUSTOMER_ID;
--Q38
 
(select customer_id,count(CUSTOMER_ID) 
from account_detail group by CUSTOMER_ID HAVING count(CUSTOMER_ID)>1);
--or
select * from CUSTOMER_DETAIL where customer_id IN
(select CUSTOMER_ID from ACCOUNT_DETAIL having count(branch_id)>1 group by
customer_id);
--Q39
select * from TRANSACTION_DETAIL where AMOUNT > (select avg(amount) from TRANSACTION_DETAIL);
--Q40
select account_id,DEPOSIT_AMOUNT from ACCOUNT_DETAIL where DEPOSIT_AMOUNT >
(select min(amount) from TRANSACTION_DETAIL);
--Q41
select account_id,max(amount) from TRANSACTION_DETAIL group by account_id ;
--Q42 incomplete
SELECT c.CUSTOMER_NAME,b.branch_location,b.branch_city,a.deposit_amount,a.CUSTOMER_ID
from BANK_DETAIL b, CUSTOMER_DETAIL c,ACCOUNT_DETAIL a
where a.branch_id=b.BRANCH_ID and c.CUSTOMER_ID=a.CUSTOMER_ID;



--Q43
select customer_name , customer_id from CUSTOMER_DETAIL where CUSTOMER_ID
IN(select customer_id from ACCOUNT_DETAIL where customer_id not in 'C002' and  
to_char(acc_open_date,'mm') =
(SELECT distinct to_char(acc_open_date,'mm') 
from ACCOUNT_DETAIL where CUSTOMER_ID='C002'));

--Q48
SELECT *
FROM TRANSACTION_DETAIL
WHERE AMOUNT > ANY
(SELECT AMOUNT FROM TRANSACTION_DETAIL WHERE TRANSACTION_TYPE='D');


--Q47
select * 
from ACCOUNT_DETAIL
where DEPOSIT_AMOUNT >
(select avg(deposit_amount) from ACCOUNT_DETAIL);

--Q46 
SELECT account_id,
deposit_amount
FROM ACCOUNT_DETAIL
WHERE DEPOSIT_AMOUNT >
(SELECT DEPOSIT_AMOUNT FROM ACCOUNT_DETAIL WHERE ACCOUNT_ID='A005');

update ACCOUNT_DETAIL SET deposit_Amount=1000 where account_id='A003'; 

--Q45
select branch_location, branch_city from BANK_DETAIL where 
BRANCH_ID IN(select BRANCH_ID from ACCOUNT_DETAIL where CUSTOMER_ID='C001');


--Q44
select * from TRANSACTION_DETAIL where TRANSACTION_TYPE IN(select TRANSACTION_TYPE from TRANSACTION_DETAIL 
where
account_id ='A004');


