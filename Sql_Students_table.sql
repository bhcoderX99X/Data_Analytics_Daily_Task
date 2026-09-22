create table Students (
    S_id int primary key, S_name varchar(100) not null , Age int ,
    Course varchar(100) , Marks int
); 
insert into Students values
	(1001 , 'Aman' , 28 , 'MCA' , 98),
    (1002, 'Rahul' , 45 , 'MCA' , 78),
    (1003, 'Divya' , 56 , 'BCA' , 68),
    (1004 , 'Saloni' , 18 , 'MBA' , 50),
    (1005 , 'Deepak' , 16 , 'BBA' , 75),
    (1006 , 'Ashish' , 35 , 'MCA' , 92),
    (1007 , 'Anmol' , 42 , 'MCA' , 88),
    (1008 , 'Harry' , 28 , 'BCA' , 98),
    (1009 , 'Alice' , 22 , 'MCA' , 99),
    (1010 , 'Aman' , 20 , 'MBA' , 61);
    
select*from Students;
    