--Creation of Customer table
drop table Customer cascade constraints;
create table Customer( CustomerID varchar(20) PRIMARY KEY, 
First_name varchar(20) not null, 
Last_name varchar(20) not null, 
phone_number number(10) not null, 
email_id varchar(50) not null check(email_id like '%@%'));

--Creation of Tables table
drop table Tables cascade constraints;
create table Tables(TableID varchar(20) PRIMARY KEY, Seat_Capacity number(1) not null);

----Creation of Reservation table for booking the table online on a specified date and time
drop table Reservation cascade constraints;
create table Reservation( ReservationID varchar(20) primary key,
CustomerID varchar(20) REFERENCES Customer(CustomerID) not null, 
TableID varchar(20) REFERENCES Tables(TableID) not null,
Reservationdate timestamp not null);

--Creation of Menu table
drop table Menu cascade constraints;
create table Menu (Item_No varchar(20) PRIMARY KEY, 
                       Item_Name varchar(20) not null,
                       Price number(10) not null,
                        Discount number(10) not null,
                        Category_type varchar (20) not null,
                        CONSTRAINT Category_type CHECK( Category_type IN('Non-Alcoholic', 'Alcoholic','Food')))
                        ;

--Creation of Orders table for tracking Order Information
drop table Orders cascade constraints; 
create table Orders( Order_ID varchar(20) PRIMARY KEY, 
TableID varchar(20) REFERENCES Tables(TableID) not null, 
--ReservationID varchar(20)  REFERENCES Reservation(ReservationID),
Billingtime timestamp not null,
settlement varchar(20) not null check(settlement in ('Cash','Credit','Debit')));
            
 
 -- Creation of Orderline table to record Individual items of each Order
 drop table OrderLine;
create table OrderLine (
                       OrderLine_Id varchar(20) PRIMARY KEY, 
                        Order_Id varchar(20) REFERENCES Orders(Order_Id) not null, 
                       Item_No varchar(20) REFERENCES Menu(Item_No) not null,
                       Quantity  number(10) not null
                 );
 
-- Sequence for generating the primary key column of Customer Table   
drop sequence customer_seq;
CREATE SEQUENCE customer_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;   
 
 -- Inserting values in Customer Table 
insert into Customer values('C'||customer_seq.nextval,'Karpagam','Vinayagam',8603083471,'karpagam.tv@gmail.com');
insert into Customer values('C'||customer_seq.nextval,'Namratha','Kasineni',8608904567,'namrathha.kasineni@gmail.com');
insert into Customer values('C'||customer_seq.nextval,'Varnika','Yertha',8603678458,'varnika.yertha@yahoo.com');
insert into Customer values('C'||customer_seq.nextval,'Prachi','Gupta',8603088904,'prachi.gupta@yahoo.com');
insert into Customer values('C'||customer_seq.nextval,'sapanjeet','chatwal',8603083479,'sapanjeet.c@yahoo.com');
insert into Customer values('C'||customer_seq.nextval,'Xinxin','Li',8906785463,'xinxin@yahoo.com');


-- Sequence for generating the primary key column of Tables table   
 drop sequence table_seq;
CREATE SEQUENCE table_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;   

 -- Inserting values in Tables Table   
insert into Tables values('T'||table_seq.nextval, 2);
insert into Tables values('T'||table_seq.nextval, 4);
insert into Tables values('T'||table_seq.nextval, 2); 
insert into Tables values('T'||table_seq.nextval, 6);
insert into Tables values('T'||table_seq.nextval, 2);
insert into Tables values('T'||table_seq.nextval, 8);
insert into Tables values('T'||table_seq.nextval, 4);
insert into Tables values('T'||table_seq.nextval, 4);

-- Sequence for generating the primary key column of Menu Table
 
drop sequence reservation_seq;
CREATE SEQUENCE reservation_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;   

-- Inserting values in Reservation Table 
insert into Reservation values('R'||reservation_seq.nextval,'C1001','T1000',TO_TIMESTAMP('12-Dec-17 12.34.34.678543','DD-MON-RR HH24.MI.SS.FF'));
insert into Reservation values('R'||reservation_seq.nextval,'C1001','T1001',TO_TIMESTAMP('12-Dec-17 12.34.34.678543','DD-MON-RR HH24.MI.SS.FF'));
insert into Reservation values('R'||reservation_seq.nextval,'C1005','T1001', TO_TIMESTAMP('12-Dec-17 12.34.34.678543','DD-MON_RR HH24.MI.SS.FF'));
insert into Reservation values('R'||reservation_seq.nextval,'C1001','T1001',TO_TIMESTAMP('11-Dec-17 9.34.34.678543','DD-MON-RR HH24.MI.SS.FF'));
insert into Reservation values('R'||reservation_seq.nextval,'C1002','T1002',TO_TIMESTAMP('10-Dec-17 8.34.34.678543','DD-MON-RR HH24.MI.SS.FF'));
insert into Reservation values('R'||reservation_seq.nextval,'C1003','T1003',TO_TIMESTAMP('9-Nov-17 7.34.34.678543','DD-MON-RR HH24.MI.SS.FF'));
insert into Reservation values('R'||reservation_seq.nextval,'C1004','T1004',TO_TIMESTAMP('8-Nov-17 6.34.34.678543','DD-MON-RR HH24.MI.SS.FF'));

-- Sequence for generating the primary key column of Menu table
drop sequence menu_seq;
CREATE SEQUENCE menu_seq
 START WITH     100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;   

-- Inserting values to Menu Table with price and discount in dollars   
insert into Menu values('M'||menu_seq.nextval,'KungPao Chicken',12,2,'Food');
insert into Menu values('M'||menu_seq.nextval,'Alfredo Penne',15,5,'Food');
insert into Menu values('M'||menu_seq.nextval,'Chicken lasagna',13,0,'Food');
insert into Menu values('M'||menu_seq.nextval,'French fries',5,0,'Food');
insert into Menu values('M'||menu_seq.nextval,'Onion Rings',5,0,'Food');
insert into Menu values('M'||menu_seq.nextval,'Heineken',7,0,'Alcoholic');
insert into Menu values('M'||menu_seq.nextval,'Baileys',7,0,'Alcoholic');
insert into Menu values('M'||menu_seq.nextval,'Lemonade',8,0,'Non-Alcoholic');
insert into Menu values('M'||menu_seq.nextval,'Coke',7,0,'Non-Alcoholic');

     
 
-- Sequence for generating the primary key column of Orders Table
drop sequence order_seq;
CREATE SEQUENCE order_seq
 START WITH     100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;   


 -- Inserting values in Orders Table 
insert into orders values('O'||order_seq.nextval,'T1000',to_timestamp('12-Dec-17 13.05.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');
insert into orders values('O'||order_seq.nextval,'T1001',to_timestamp('12-Dec-17 13.20.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');
insert into orders values('O'||order_seq.nextval,'T1007',to_timestamp('12-Dec-17 13.25.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');
insert into orders values('O'||order_seq.nextval,'T1001',to_timestamp('11-Dec-17 11.05.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');
insert into orders values('O'||order_seq.nextval,'T1002',to_timestamp('10-Dec-17 10.05.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');
insert into orders values('O'||order_seq.nextval,'T1003',to_timestamp('9-Nov-17 9.10.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');
insert into orders values('O'||order_seq.nextval,'T1004',to_timestamp('8-Nov-17 9.10.05.678543','DD-MON-RR HH24.MI.SS.FF'),'Cash');


-- Sequence for generating the primary key column of Orderline Table
drop sequence orderline_seq;
CREATE SEQUENCE orderline_seq
 START WITH     100
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


 -- inserting values in Orderline Table   
insert into Orderline values('OL'||orderline_seq.nextval,'O101', 'M100',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O101', 'M101',2);
insert into Orderline values('OL'||orderline_seq.nextval,'O101', 'M107',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O102', 'M100',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O103', 'M101',3);
insert into Orderline values('OL'||orderline_seq.nextval,'O104', 'M101',2);
insert into Orderline values('OL'||orderline_seq.nextval,'O104', 'M103',2);
insert into Orderline values('OL'||orderline_seq.nextval,'O104', 'M106',2);
insert into Orderline values('OL'||orderline_seq.nextval,'O104', 'M102',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O105', 'M103',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O105', 'M106',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O106', 'M102',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O106', 'M107',1);
insert into Orderline values('OL'||orderline_seq.nextval,'O100', 'M103',1);

