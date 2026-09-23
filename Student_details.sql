create database bhoopendra1;
use bhoopendra1;

create table Student_details (
  S_id int primary key, S_name varchar(100), Age int, Course varchar(100), Marks int 
  );
insert into Student_details value 
    (1001 , 'Aman' , 29 , 'BCA' , 25),
	(1002 , 'Rahul' , 23 , 'MCA' , 18),
	(1003 , 'Divya' , 32 , 'MBA' , 35),
	(1004 , 'Harry' , 19 , 'BCA' , 19),
	(1005 , 'Aman' , 25, 'MCA' , 29),
	(1006 , 'Alice' , 32 , 'BBA' , 35),
	(1007 , 'Luci' , 24 , 'MCA' , 20),
    (1008 , 'Deepak' , 38 , 'MCA' , 27),
    (1009 , 'Luci' , 27 , 'MCA' , 38);
    
select*from Student_details where Course= 'MCA';
select*from Student_details where Age>21 and Age<30;
select S_id, S_name, Course where marks = (select max(marks) from student_details);






   


   