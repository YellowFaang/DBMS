create Database Insurance

use Insurance

CREATE TABLE person (
			driverid varchar(10),
			fname char(15) not null,
			address varchar(30),
			primary key (driverid)  
			)

drop table partcipated	
drop table owns
drop table accident
drop table car
drop table person

select * from person
insert into  PERSON values ('111','John Smith' , 'SP Road, Bangalore-12')
insert into  PERSON values ('112','Ramesh Babu' , 'KP Nagar, Udupi -13')
insert into  PERSON values ('113','Raju SK' , 'KS Circle, Mangalore-12')
insert into  PERSON values ('114','Ramesh Babu' , 'AS Road, Bangalore-14')
insert into  PERSON values ('115','Alica wallace' , 'SS Road, Karkala-16')

select * from PERSON

CREATE TABLE car (
			regno varchar(10),
			model varchar(10)not null,
			cyear int,
			primary key(regno) 
		)

insert into  CAR values ('KA-12','FORD' ,2005)
insert into  CAR values ('KA-13','SWIFT' ,2010)
insert into  CAR values ('MH-11','INDIGO' ,2009)
insert into  CAR values ('AP-10','SWIFT' ,2008)
insert into  CAR values ('TN-11','FORD' ,2015)
insert into  CAR values ('TN-12','TOYOTA' ,2001)
insert into  CAR values ('MH-14','SWIFT' ,2001)
insert into  CAR values ('KL-15','TOYOTA' ,2001)
insert into  CAR values ('KL-4','INDIGO' ,2001)
insert into  CAR values ('AP-05','SANTRO' ,2001)
insert into car values('KA-19','TOYOTA',2001)
insert into car values('KA-20','TOYOTA',2001)

select * from CAR

CREATE TABLE accident  (
			reportno int ,
			accdate datetime,
			location varchar(20),
			primary key(reportno)
			)


insert into  ACCIDENT values (1,'1998-07-22' ,'Nitte')
insert into  ACCIDENT values (2,'1998-07-22','Karkala')
insert into  ACCIDENT values (12,'1998-07-22' ,'Mangalore')
insert into  ACCIDENT values (3,'1998-07-23','Mangalore')
insert into  ACCIDENT values (4,'1990-09-09','Bhatkal')
insert into  ACCIDENT values (5,'2001-02-22' ,'Udupi')
insert into  ACCIDENT values (6,'1990-09-09','Udupi')
insert into  ACCIDENT values (15,'1981-07-22' ,'Udupi')

select * from ACCIDENT

insert into  ACCIDENT values (7,'1981-09-09','Karkala')
insert into  ACCIDENT values (8,'1990-09-09','Bhatkal')
insert into  ACCIDENT values (9,'2001-02-22' ,'Udupi')
insert into  ACCIDENT values (10,'1998-02-02','Udupi')
insert into  ACCIDENT values (11,'1998-01-02','Bhatkal')
insert into  ACCIDENT values (13,'1998-07-22','Udupi')
insert into  ACCIDENT values (14,'1998-07-22','Karkala')


CREATE TABLE owns    (
			driverid varchar(10) ,
			regno varchar(10)
			primary key(driverid,regno) 
			foreign key(driverid) references PERSON(driverid)on delete cascade on update cascade,
			foreign key(regno) references CAR(regno)on delete cascade on update cascade,
			unique(regno)
		    )

insert into  OWNS values ('111','KA-13')
insert into  OWNS values ('111','KA-12')
insert into  OWNS values ('111','MH-11')

insert into  OWNS values ('112','AP-10')
insert into  OWNS values ('112','TN-11')
insert into owns values('113','KA-19')
insert into owns values('112','KA-20')


insert into  OWNS values ('113','TN-12')
insert into  OWNS values ('113','KL-15')

insert into  OWNS values ('114','AP-05')
insert into  OWNS values ('114','KL-4')
insert into  OWNS values ('115','MH-14')


select * from OWNS

CREATE TABLE PARTCIPATED
(
driverid varchar(10) ,
regno varchar(10),
reportno  int,
dmgamt int,
CONSTRAINT P_PK primary key(driverid,regno,reportno) ,
foreign key(driverid) references PERSON(driverid)on delete cascade on update cascade,
foreign key(regno) references CAR(regno)on delete cascade on update cascade,
foreign key(reportno) references ACCIDENT(reportno)  on delete cascade on update cascade,
foreign key(driverid,regno) references OWNS(driverid,regno),
unique(reportno) 
)


insert into  PARTCIPATED values ('111','KA-12',1,20000)
insert into  PARTCIPATED values ('111','KA-13',2,10000)
insert into  PARTCIPATED values ('111','KA-12',3,60000)
insert into  PARTCIPATED values ('111','KA-12',4,60000)
insert into  PARTCIPATED values ('111','KA-12',5,60000)
insert into  PARTCIPATED values ('111','KA-12',15,40000)
insert into  PARTCIPATED values ('111','KA-13',6,10000)
insert into  PARTCIPATED values ('111','MH-11',12,20000)
 
insert into  PARTCIPATED values ('112','AP-10',7,30000)
insert into  PARTCIPATED values ('112','TN-11',8,40000)
insert into  PARTCIPATED values ('112','AP-10',13,20000)
insert into  PARTCIPATED values ('112','TN-11',14,10000)

insert into  PARTCIPATED values ('113','TN-12',9,40000)
insert into  PARTCIPATED values ('113','KL-15',10,50000)
insert into  PARTCIPATED values ('113','TN-12',11,20000)


1. Find the total number of people who owned cars 
that were involved in accidents in 1989.

select count (distinct P.driverid)
from accident A, partcipated P
where A.reportno = P.reportno 
and A.accdate between  '1998-01-01' and  '1998-12-31'

select * from accident
select * from partcipated order by(reportno)


select count (distinct P.driverid)
from accident A, partcipated P
where A.reportno = P.reportno 
and year(A.accdate) = '1998'  


select count (distinct P.driverid)
from  partcipated P 
where P.reportno  in(select reportno  
					 from accident 
                     where reportno = P.reportno and year(accdate)  ='1998')
 
select count (distinct P.driverid)
from  partcipated P 
where P.reportno  in(select reportno  
					from accident 
                     where  year(accdate)  ='1998')
					


2.  Find the number of accidents in which the cars belonging to
“John Smith” were involved.

select count(reportno) AS NumberOfAccidents
from partcipated
where driverid in(select driverid
				   from PERSON
				 where fname LIKE 'John Smith')


select  count (P.reportno) as NO_OF_ACC
from   partcipated P,  person PN
where P.driverid =  PN.driverid 
and   PN.fname = 'John Smith'   

3.Update the damage amount for the car with reg number “KA-12” 
in the accident with report number “1” to $3000.

update PARTCIPATED  set dmgamt = 3000 
where reportno = 1 and regno = 'KA-12'

#############  PRACTICE QUERIES   #############

1. Display names of the drivers, whose toyota cars were 
involved in accident in the year 2001

select fname
from person
where driverid in(select driverid
                 from partcipated
				 where regno in(select regno
								from car
								where model='TOYOTA' and cyear=2001)) 
select fname
from person p,partcipated pa,car c
where p.driverid=pa.driverid and pa.regno=c.regno
and model='TOYOTA' and cyear=2001


3.Find the number of accidents in which the cars 
belonging to specific model were involved.

select count(reportno) AS No_of_Cars
from partcipated
where regno in(select regno
				from car
				where model ='SWIFT')

select count(reportno) AS No_of_Cars
from partcipated AS p, car AS c
where p.regno=c.regno
and model='SWIFT'

select  count (P.reportno) as NO_OF_ACC
from   partcipated P,  car C
where P.regno =  C.regno 
and   C.model  = 'SWIFT'


4.List the names of  people who owned 
cars that were involved in accidents in 1998.

select fname
from person
where driverid in(select driverid
					from partcipated
					where reportno in(select reportno
										from accident
										where year(accdate)=1998)

select distinct(fname)
from person p,partcipated pa,accident a
where p.driverid=pa.driverid and
pa.reportno =a.reportno
and  year(accdate)=1998

5.List the name of owners who own atleast two TOYOTA cars.

select o.driverid,model
from owns o,car c
where o.regno=c.regno and model='TOYOTA'
group by model,o.driverid

having count(o.driverid)>=2


select o.driverid,fname, model
from owns o,car c, person p
where o.regno=c.regno and p.driverid=o.driverid and model='TOYOTA'
group by model,o.driverid,fname
having count(o.driverid)>=2


select P.fname
from PERSON P,OWNS O,CAR C
where P.driverid=O.driverid and C.regno=O.regno and C.model='TOYATA'
group by P.fname
having count(C.regno)>=2

6.  Display name and driverid of thise whoescars are not 
involved in any accident

select fname,driverid
from person p
where not exists(select regno
                 from partcipated pa
				 where pa.driverid=p.driverid)

select driverid,fname
from person
where driverid not in(select driverid
                      from partcipated)

select driverid
from person 
except 
select driverid
from partcipated

7.List the names of  owners and every car owned by them

select p.fname,p.driverid,regno
from owns o, person p
where o.driverid=p.driverid

8.List the names of  owners whose every car is involved in accidents in 1998

select P.fname
from PERSON P
where not exists(
                  select Z.regno from OWNS Z
                  where =Z.driverid and
                   Z.regno not in 
                  (select R.regno 
                   from ACCIDENT A,PARTCIPATED R
                   where A.reportno=R.reportno and year(A.accdate)='1998'))

select P.fname
from PERSON P
where not exists(
                  select Z.regno from OWNS Z
                  where P.driverid=Z.driverid and
                   Z.regno not in 
                  (select C.regno 
                   from CAR C,ACCIDENT A,PARTCIPATED R
                   where P.driverid=R.driverid and C.regno=R.regno
                   and A.reportno=R.reportno and year(A.accdate)='1998'))


				   					 
9. Find the name of owner and his car 
that has maximum number of accidents in 1998

select fname,regno,count(PA.reportno)
from person P, partcipated PA,accident A
where P.driverid=PA.driverid and A.reportno=PA.reportno and year(accdate)=1998
group by fname,regno 
having count(PA.reportno)>=ALL(select count(p.reportno)
						from partcipated p, accident a
						where p.reportno=a.reportno
						and year(accdate)=1998
						group by regno)

select distinct P.fname,O.regno
from PERSON P,OWNS O,ACCIDENT A,PARTCIPATED R
where P.driverid=R.driverid and O.regno=R.regno and R.reportno=A.reportno and year(A.accdate)='1998' 
group by P.fname,O.regno
having count(*) >= ALL ( select count(distinct A1.reportno) 
                        from OWNS O1,PERSON P1,ACCIDENT A1,PARTCIPATED R1
                        where P1.driverid=R1.driverid and O1.regno=R1.regno and R1.reportno=A1.reportno and year(A1.accdate)='1998' 
                        group by P1.fname,O1.regno)


10.Find the name of owner and his car 
that is involved in atleast one  accident in 1998

select distinct P.fname,R.regno
from PERSON P,OWNS O,ACCIDENT A,PARTCIPATED R
where P.driverid=R.driverid and O.regno=R.regno and R.reportno=A.reportno
and year(A.accdate)='1998' 
group by P.fname,R.regno
having count(R.reportno)>=ANY(select count(distinct A1.reportno) 
                        from OWNS O1,PERSON P1,ACCIDENT A1,PARTCIPATED R1
                        where P1.driverid=R1.driverid and O1.regno=R1.regno and R1.reportno=A1.reportno and year(A1.accdate)='1998' 
                        group by P1.fname,O1.regno)

*****************************************************
4.Add a new accident to the database; 
assume any values for required attributes.

 
We assume the driver was “Ramesh Babu,” although it could be someone else.
Also, we assume “Ramesh Babu” owns one Toyota. First we must find the license of
the given car. Then the participated and accident relations must be updated
in order to both record the accident and tie it to the given car. We assume
values “Berkeley” for location, ’2001-09-01’ for date and date, 4007 for reportnumber
and 3000 for damage amount.

insert into accident values (16, '2001-09-01', 'Karkala')

insert into partcipated
select O.driverid, C.regno, 16, 100000
from person P, owns O, car C
where P.fname = 'Ramesh Babu'    
and P.driverid = O.driverid 
and O.regno = C.regno 
and C.model = 'SWIFT'

5. Delete the Mazda belonging to “John Smith”.

delete from  car
where model = 'INDIGO' and regno in
(select regno
from person P, owns O
where P.fname = 'John Smith' and P.driverid = O.driverid)



6.List the name of owners who own atleast two TOYOTA cars.

select P.fname
from PERSON P,OWNS O,CAR C
where P.driverid=O.driverid and C.regno=O.regno and C.model='TOYATA'
group by P.fname
having count(C.regno)>=2

7.	List the name of owner who owns maximum TOYOTA cars.

select P.fname
from PERSON P,CAR C,OWNS O
where P.driverid=O.driverid and C.regno=O.regno and C.model='TOYATA'
group by P.fname
having count(C.regno)>=all(select count(distinct C.regno)
                           from PERSON P1,CAR C1,OWNS O1
                           where P1.driverid=O1.driverid and C1.regno=O1.regno and C1.model='TOYATA'
                           group by P1.fname)

8.Find  the name of  owner who owns cars  having  minimum damage amount for  accidents in 2008

select P.fname,R.dmgamt
from PERSON P,OWNS C,PARTCIPATED R,ACCIDENT A
where P.driverid=R.driverid and C.regno=R.regno and R.reportno=A.reportno and year(A.accdate)='1998'
group by P.fname,R.dmgamt
having R.dmgamt in (select min(dmgamt)
                    from PARTCIPATED B,ACCIDENT C
                    where B.reportno=C.reportno and year(C.accdate)='1998')
     

10.List the names of   owners whose every car is involved in accidents on a specific day.
 
select P.fname
from PERSON P
where not exists( select O.regno
                  from OWNS O
                  where O.driverid=P.driverid
                  and O.regno not in( select R.regno
                                      from PARTCIPATED R,CAR C,ACCIDENT A
                                      where R.driverid=P.driverid and C.regno=R.regno
                                      and A.reportno=R.reportno and A.accdate='22 july 1998'))

11.List the names of people who owned cars that were involved in accidents on a specific day and 
 atleast two cars of each owner are involved.
 
 select P.fname
 from PERSON P,OWNS C,PARTCIPATED R,ACCIDENT A
 where P.driverid=R.driverid and C.regno=R.regno and R.reportno=A.reportno
 and A.accdate='22 july 1998'
 group by P.fname
 having count(C.regno)>=2
 

 12.List Owner-Name, Car Regno, Number of accidents, and average damage amount for the year 2008.
 
 select P.fname,C.regno,count(A.reportno),avg(R.dmgamt)
 from PERSON P,OWNS C,PARTCIPATED R,ACCIDENT A
 where P.driverid=R.driverid and C.regno=R.regno and A.reportno=R.reportno and year(A.accdate)='1998'
 group by P.fname,C.regno

 13.Find the total number of people who owned cars that were involved in accidents in 2008

select count(distinct O.driverid)
from OWNS O,PARTCIPATED P,ACCIDENT A
where O.driverid=P.driverid and P.reportno=A.reportno and year(A.accdate)='2001'


14.Find the number of accidents in which cars belonging to a specific model were involved

select count(P.reportno)
from CAR C,PARTCIPATED P
where C.regno=P.regno and C.model='TOYATA'


15.Find the location at which maximum accidents occur in 2008

select A.location
from ACCIDENT A,PARTCIPATED P
where A.reportno=P.reportno and year(A.accdate)='1998'
group by A.location
having count(A.reportno)>=ALL( select count(A1.reportno)
                               from ACCIDENT A1,PARTCIPATED P1
                               where A1.reportno=P1.reportno and year(A1.accdate)='1998'
                               group by A1.location) 
      

16.Find the people who owned cars that were involved in accidents at every location.

select P.fname
from PERSON P
where not exists( select distinct A.location  
                  from ACCIDENT A
                  where A.location not in( select A1.location
                                         from ACCIDENT A1,PARTCIPATED P1,OWNS O
                                         where A1.reportno=P1.reportno and P1.driverid=P.driverid
                                         and P1.regno=O.regno))
      

17.Find the number of  owners whose every car is involved in accidents in 2008.

select count(distinct O.driverid) as No_of_Owners
from OWNS O
where not exists( select C.regno
                  from CAR C
                  where C.regno=O.regno
                  and C.regno not in( select distinct P.regno
                                      from ACCIDENT A,PARTCIPATED P
                                      where P.regno=O.regno and A.reportno=P.reportno 
                                      and year(A.accdate)='1998'))
     

18.Find the location at which maximum number of Mazda cars are involved in accidents
             
 select A.location 
 from ACCIDENT A,PARTCIPATED P,CAR C
 where A.reportno=P.reportno and C.regno=P.regno and C.model='SWIFT'
 group by A.location
 having count(distinct C.regno)>=ALL( select count(distinct C1.regno)
                                     from CAR C1,ACCIDENT A1,PARTCIPATED P1
                                     where C1.regno=P1.regno and A1.reportno=P1.reportno and C1.model='SWIFT'
                                     group by A1.location)
     

19.List the damage amount for each car

select C.regno,C.model,sum(P.dmgamt)
from CAR C,PARTCIPATED P
where C.regno=P.regno 
group by C.regno,C.model


20.List the owner/owners of the car with the maximum damage amount

select P.fname,R.dmgamt
from OWNS O,PERSON P,PARTCIPATED R
where P.driverid=O.driverid and R.driverid=O.driverid and R.regno=O.regno
group by P.fname,R.dmgamt
having R.dmgamt=(select max(dmgamt) from PARTCIPATED)

21.Give the details of all the owners(ownerid,name,regno,model)

select O.driverid,P.fname,C.regno,C.model
from OWNS O,PERSON P,CAR C
where P.driverid=O.driverid and O.regno=C.regno

22.Find the no.of cars owned by each owner

select O.driverid,P.fname,count(C.regno)
from PERSON P,OWNS O,CAR C
where O.driverid=P.driverid and C.regno=O.regno
group by O.driverid,P.fname

23.Give the details of each car showing the regno,model, no. of accident    

select C.regno,C.model,count(P.reportno)
from CAR C,PARTCIPATED P
where C.regno=P.regno 
group by C.regno,C.model

24.Give the details of the owners who owned 2 or more cars and registered after 2000
    and total damage amount for a car is between 10,000 and 25,000
    
select P.driverid,P.fname
from PERSON P,PARTCIPATED R,CAR C
where C.cyear > 1979 and R.driverid=P.driverid  and C.regno=R.regno
group by P.driverid,P.fname
having (sum(R.dmgamt)>=10000 and sum(dmgamt)<=210000)and count(C.regno)>=2 

25.Give the owners details which include ownerid,name,car model,no.of cars owned.

select P.driverid,P.fname,C.model,count(C.regno)
from OWNS O,CAR C,PERSON P
where P.driverid=O.driverid and C.regno=O.regno
group by P.driverid,P.fname,C.model


26.Find the names of owners whose atleast one car is involved in accidents every year.

select P.fname
from PERSON P
where not exists( select distinct year(A.accdate)
                  from ACCIDENT A
                  where year(A.accdate) not in( select distinct year(A1.accdate)
                                                from ACCIDENT A1,PARTCIPATED P1,OWNS O
                                                where A1.reportno=P1.reportno and O.driverid=P.driverid
                                                and P1.driverid=O.driverid))


















