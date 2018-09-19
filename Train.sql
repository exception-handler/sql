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
--ass 1
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
select * from TRANSACTION_DETAIL where TRANSACTION_TYPE IN(select TRANSACTION_TYPE from TRANSACTION_DETAIL where
account_id ='A004');

--Q43



--ass 1

Answer Q1
SELECT first_name,hire_date,salary*3 as quater,salary FROM employees;
Answer Q2
SELECT last_name,salary,(salary*12)-(0.15*(salary*12)) FROM employees;

Answer Q3
SELECT first_name,hire_date,salary,salary*3 as "Quaterly Salary" FROM employees;

Answer Q4
SELECT last_name,salary,(salary*12)-(0.15*(salary*12)) as "Net Take Home Salary" FROM employees;

Answer Q5
SELECT 'Employee '||first_name||' was '||' Hired On '||hire_date||' In '||department_id||
' On '||salary||' Monthly Salary' FROM employees;

Answer Q6
SELECT distinct salary FROM employees;

Answer Q7
SELECT customer_name FROM customer_detail where customer_address='Khar';

Answer Q8
SELECT c.customer_name, b.branch_city,a.deposit_amount
FROM ACCOUNT_DETAIL a,BANK_DETAIL b,CUSTOMER_DETAIL c 
where a.CUSTOMER_ID=c.CUSTOMER_ID and a.BRANCH_ID=b.BRANCH_ID and a.DEPOSIT_AMOUNT>5000;

Answer Q9
SELECT customer_name FROM customer_detail where customer_name LIKE 's%';

Answer Q10
SELECT * FROM bank_detail where branch_city IN ('Pune','Delhi','Indore');

Answer Q11
SELECT BRANCH_LOCATION FROM bank_detail where branch_city IN ('Pune','Delhi');

Answer Q12
SELECT * FROM TRANSACTION_DETAIL where TRANSACTION_TYPE='D' and amount between '4000' and '8000';

Answer Q13
SELECT * FROM customer_detail order by customer_name desc;

Answer Q14
SELECT *
FROM CUSTOMER_DETAIL c,
ACCOUNT_DETAIL a
WHERE c.CUSTOMER_ID=a.CUSTOMER_ID
ORDER BY DEPOSIT_AMOUNT DESC;

Answer Q15
SELECT * FROM ACCOUNT_DETAIL  order by deposit_amount,ACC_OPEN_DATE  desc;

Answer Q16
SELECT * FROM CUSTOMER_DETAIL where customer_name like 'A%' or customer_name like 'S%' and customer_name like '%u%';

Answer Q17
SELECT  initcap(customer_name),upper(CUSTOMER_ADDRESS) from CUSTOMER_DETAIL;

Answer Q18
SELECT * FROM TRANSACTION_DETAIL where TRANSACTION_DATE < (sysdate-5);

Answer Q19
SELECT first_name,hire_date,round(sysdate-hire_date) days,round((sysdate-hire_date)/7) weeks,round((sysdate-hire_date)/365) years 
FROM EMPLOYEES;

Answer Q20
SELECT employee_id , to_char(hire_date,'fmYear,month,dd,day') FROM EMPLOYEES;

Answer Q21
SELECT location_id, substr(STREET_ADDRESS,1,20) FROM LOCATIONS;

Answer Q22
SELECT EMPLOYEE_ID , RPad(lpad(salary,10,'*'),15,'*') FROM EMPLOYEES;

Answer Q23
SELECT first_name , salary, commission_pct , decode(commission_pct,null,'employee earned no commission',commission_pct)
FROM EMPLOYEES;

Answer Q24
SELECT first_name,salary,commission_pct,nullif(commission_pct,.1) FROM EMPLOYEES;

Answer Q25
SELECT first_name,department_id, CASE department_id
WHEN 50 THEN 'hr department' 
WHEN 80 THEN 'TRAINING TEAM'
ELSE 'DEVELOPMENT TEAM'
end "RESULT"
FROM EMPLOYEES;

  Answer Q27 ****


  Answer Q28
  SELECT c.customer_id,
  c.customer_name,
  a.account_id
  FROM customer_detail c
  LEFT OUTER JOIN ACCOUNT_DETAIL a
  ON c.CUSTOMER_ID=a.CUSTOMER_ID;

or

  SELECT c.customer_id,
  c.customer_name,
  a.account_id
  FROM customer_detail c,
  ACCOUNT_DETAIL a
  WHERE c.CUSTOMER_ID=a.CUSTOMER_ID(+);



  Answer Q29
  SELECT e.employee_id,
  e.first_name,
  e.salary employeesalary,
  m.salary managersalary,m.SALARY-e.SALARY difference
  FROM employees e, employees m
  WHERE e.MANAGER_ID=m.employee_id(+);


  Answer Q30
  SELECT e.employee_id,
  e.first_name
  ||e.last_name name,
  e.salary,
  d.department_name,
  l.city,
  l.postal_code
  FROM EMPLOYEES e,DEPARTMENTS d,LOCATIONS l
  WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
  and d.LOCATION_ID= l.LOCATION_ID
  and e.SALARY > 5000;
  
  Answer Q31
  select count(account_id) from ACCOUNT_DETAIL where to_char(ACC_OPEN_DATE,'yy')='04';

  Answer Q32
  SELECT customer_name
  FROM customer_detail
  WHERE customer_id IN
  (SELECT customer_id
  FROM ACCOUNT_DETAIL
  GROUP BY customer_id
  HAVING COUNT(account_id)>1);
  select * from ACCOUNT_DETAIL;
 
 
  Answer Q33
  
  answer Q38
  select CUSTOMER_ID,count(branch_id) from ACCOUNT_DETAIL group by customer_id;
 
 
 answer Q39
 select TRANSACTION_ID,AMOUNT from TRANSACTION_DETAIL where AMOUNT>(select avg(amount) from TRANSACTION_DETAIL);
 
 answer Q40
 SELECT account_id
 FROM ACCOUNT_DETAIL
 WHERE deposit_amount>
  ( SELECT MIN(amount) FROM TRANSACTION_DETAIL
  ); 
  
  answer Q41
  select ACCOUNT_ID, max(amount) from TRANSACTION_DETAIL group by ACCOUNT_ID;
  
  
  answer Q42
  
  
  answer Q43
  
  
  answer Q44
   SELECT *
   FROM TRANSACTION_DETAIL
   WHERE TRANSACTION_TYPE IN
   (SELECT transaction_type FROM TRANSACTION_DETAIL WHERE ACCOUNT_ID='A004'
  );
  
  answer Q45
  SELECT branch_location,
  branch_city
  FROM BANK_DETAIL
   WHERE BRANCH_ID IN
  (SELECT branch_id FROM ACCOUNT_DETAIL WHERE CUSTOMER_ID='C001'
  );
  
  answer Q46
  SELECT ACCOUNT_ID ,
  DEPOSIT_AMOUNT
 FROM ACCOUNT_DETAIL
 WHERE ACCOUNT_ID IN
  (SELECT account_id
  FROM TRANSACTION_DETAIL
  WHERE amount>
    (SELECT amount FROM TRANSACTION_DETAIL WHERE ACCOUNT_ID='A005'
    )
  );

 answer Q47
  SELECT *
  FROM ACCOUNT_DETAIL
  WHERE deposit_amount >
  (SELECT AVG(deposit_amount) FROM account_detail
  );
  
  answer Q48
  SELECT *
  FROM TRANSACTION_DETAIL
  where amount> ANY
  (select amount from TRANSACTION_DETAIL where transaction_type='D');
  
  
  
  
  select * from ACCOUNT_DETAIL;
  ans 1
  insert into account_detail values('A006','C004','B003','R',6000,'28-06-17');
  ans 2
  insert into CUSTOMER_DETAIL values('C','Ankit','Delhi');
  ans 3
  delete from CUSTOMER_DETAIL where customer_name='Ankit';
  ans 4
  insert into ACCOUNT_DETAIL values('A001','C005','B009','S',52454,'3-06-18');
  select * from account_detail;
  ans 5
  delete from ACCOUNT_DETAIL where account_id='A001';
  ans 6
  select * from transaction_detail;
  insert into TRANSACTION_DETAIL values('T008','N','A006',15000,'03-05-17');
  
  
  
  ans 13
  select employee_name
  from EMPLOYEES
  where projects=(SELECT project FROM EMPLOYEES where employee_name='Tom');
  
  ans 14
  select first_name||' '||last_name
  from EMPLOYEES
  where location_id IN
  (select location_id 
  from employees
  where manager_id =
  (select manager_id from departments where 
  department_name='IT')
  );
  
  
  
  20.
  SELECT branch_id,
  COUNT(account_id)
  FROM account_detail
  GROUP BY branch_id
  HAVING COUNT(account_id) < ANY
  (SELECT COUNT(DISTINCT account_id) FROM account_detail GROUP BY customer_id
  );
  
21.
  select customer_name from customer_Detail where 1<= any(select count(customer_id)
  from account_detail group by customer_id);
  
22.
  create table account_detail_new as select * from ACCOUNT_DETAIL;
  
23.
 CREATE TABLE student_table1
  (
    id                NUMBER,
    name              VARCHAR2(22),
    city              VARCHAR(2),
    course            VARCHAR(20) default 'Foundation',
    registration_date DATE DEFAULT sysdate,
    CONSTRAINT city11 CHECK(city IN ('delhi','noida','gurgaon'))
    );

24.
  desc CUSTOMER_DETAIL;
  
25.
  create table transaction_detail2 as select transaction_id,transaction_type from transaction_detail;
  
26.
  alter table customer_detail modify customer_name varchar2(50);
  
27.
  alter table customer_detail add reference varchar(30);
  
28.
  alter table customer_detail drop column reference ;
  
29.
  alter table customer_detail modify customer_name varchar2(20);
  
30
  alter table student_table rename to student_test_table;
  
31.
  commit;
  delete from student_test_table;
  select * from student_test_table;
  rollback;
  select * from student_test_tavle;
  
32
  SELECT constraint_name,
  constraint_type,
  search_condition
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME='ACCOUNT_DETAIL';
  
33.
  ALTER TABLE account_detail disable CONSTRAINT CHK10019 CASCADE;
  ALTER TABLE account_detail disable CONSTRAINT SYS_C003997 CASCADE;
  ALTER TABLE account_detail disable CONSTRAINT SYS_C003998 CASCADE;
  ALTER TABLE account_detail disable CONSTRAINT SYS_C003999 CASCADE; 
  
34.
  ALTER TABLE account_detail enable CONSTRAINT CHK10019 ;
  ALTER TABLE account_detail enable CONSTRAINT SYS_C003997 ;
  ALTER TABLE account_detail enable CONSTRAINT SYS_C003998 ;
  ALTER TABLE account_detail enable CONSTRAINT SYS_C003999 ;
  
35.
  alter table account_detail_new disable constraint customer_id;
    
  
  
  
  
  
  --ass 3
  
  ans 1
  create index index1 on customer_detail(customer_address);
  
  ans 2
  create VIEW customer_vw AS
  SELECT c.customer_id,
  c.customer_name,
  a.account_id,
  b.BRANCH_LOCATION
  FROM CUSTOMER_DETAIL c,
  ACCOUNT_DETAIL a,
  BANK_DETAIL b
  WHERE a.CUSTOMER_ID=c.CUSTOMER_ID
  AND b.BRANCH_ID=a.BRANCH_ID;

  ans 3
  
  update customer_detail set CUSTOMER_NAME='vipin' where customer_id='C001';
  update BANK_DETAIL set BRANCH_LOCATION='BHOPAL' where BRANCH_ID='B001';
  
  ans 4
  update customer_vw set CUSTOMER_NAME='vipin',BRANCH_LOCATION='BHOPAL' where CUSTOMER_ID='C001';
  
  ans 5
  
CREATE VIEW transaction_Account_Customer_Bank AS
SELECT t.amount,
  a.deposit_amount,
  c.customer_name,
  c.customer_address,
  b.branch_location,
  b.branch_city
FROM transaction_detail t,
  ACCOUNT_DETAIL a,
  CUSTOMER_DETAIL c,
  BANK_DETAIL b
WHERE a.customer_id=c.customer_id
AND t.account_id   =a.account_id
AND a.branch_id    =b.branch_id
WITH read only;
  
  ans 6
  
  create sequence transaction_seq
  increment by 1
  start with 10
  maxvalue 999999;
  
  ans 7
  drop sequnece Transaction_seq;
  
  ans 8
  CREATE sequence cust_seq 
  increment BY 1 
  start with 8 
  maxvalue 100 nocycle;
  
  ans 9
  create sequence cust_seql
  increment BY 1
  start with 101
  maxvalue 200
  nocycle;
  
  ans 10
  drop sequence cust_seq;
  drop sequence cust_seq1;
  
  ans 11
  create synonym  tacb for transanction_account_customer_bank;
  drop synonym tacb;
  

  
  
  

   select salary from employees order by salary desc; 
   SELECT COUNT(SALARY) FROM EMPLOYEES ;
   
   SELECT DISTINCT last_name,salary
   FROM employees e1
   WHERE 4=(SELECT COUNT(DISTINCT(salary)) FROM employees e2 WHERE e2.salary>e1.salary);
   
   
   
   COMMIT;