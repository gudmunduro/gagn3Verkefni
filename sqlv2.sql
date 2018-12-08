use 1404002030_progresstracker_v1;

select * from students;
select * from courses;

# 1

drop table if exists Students;

create table Students (
	studentID int unsigned auto_increment primary key,
    studentName varchar(50),
    credits int(4),
    trackID int(11),
    foreign key (trackID) references Tracks(trackID)
);

# 2

delimiter \\

drop trigger if exists restrictorsTrigger;

create trigger restrictorsTrigger before insert on restrictors
for each row
begin
	if new.restrictorID = new.courseNumber then
		signal sqlstate '46000';
	end if;
end \\

delimiter ;

insert into restrictors(courseNumber, restrictorID, restrictorType) values ("aaaaaaaaaa", "aaaaaaaaaa", "b");

# 3

select * from restrictors;

delimiter \\

drop trigger if exists restrictorsUpdateTrigger;

create trigger restrictorsUpdateTrigger before update on restrictors
for each row
begin
	if new.restrictorID = new.courseNumber then
		signal sqlstate '46000';
	end if;
end \\

delimiter ;

set sql_safe_updates = 0;

update Restrictors set courseNumber = 'STÆ103' where restrictorID = 'STÆ103';

# 4

select * from tracks;
select * from trackcourses;
select * from courses;
select * from Registration;

insert into trackcourses(trackID, courseNumber, semester, mandatory) values
(1, "EÐL103", 1, 1),
(9, "FOR3G3U", 1, 1),
(9, "GSF2A3U", 1, 1),
(9, "FORR703", 1, 1),
(9, "GSF2B3U", 1, 1),
(9, "GSF3A3U", 1, 1),
(9, "GSF3B3U", 1, 1),
(1, "STÆ103", 1, 1),
(1, "STÆ203", 1, 1),
(1, "STÆ303", 1, 1),
(1, "STÆ313", 1, 1);


drop table Registration;
create table Registration(StudentID int(10), TrackID int(11), CourseNum char(10), RegDate date, Passed bool);

insert into Registration(StudentID, TrackID, TrackNum, RegDate, Passed) values
(10, 1, "EÐL103", '2018-12-02', 1),
(50, 9, "FOR3G3U", '2018-02-02', 1),
(50, 9, "GSF2A3U", '2018-08-02', 1),
(50, 9, "FORR703", '2018-06-02', 0),
(50, 9, "GSF2B3U", '2018-07-02', 1),
(50, 9, "GSF3A3U", '2018-05-02', 0),
(50, 9, "GSF3B3U", '2018-02-02', 0),
(50, 1, "STÆ103", '2018-04-02', 1),
(50, 1, "STÆ203", '2018-06-02', 1),
(50, 1, "STÆ303", '2018-02-02', 1),
(50, 1, "STÆ313", '2018-10-02', 1);



delimiter //

drop procedure if exists SumOfCredits;

create procedure SumOfCredits()
begin
	select CourseNum, (count(*) * 3) as Credits from Registration where StudentID = 50 and Passed = true;
end //

delimiter ;

call SumOfCredits();

# 5

select * from courses;

drop table if exists selectedcourses;

create table selectedcourses(
	studentID int(10) not null,
	courseNumber char(10) not null,
    foreign key (studentID) references students(studentID),
    foreign key (courseNumber) references courses(courseNumber)
);

delimiter //

drop procedure if exists AddMandtoryCourses;

create procedure NewStudentCourses()
begin
	
    declare StudentID int(10);
    
    declare CourseNum char(10);
    
    declare Passed bool;
    
    declare AddMandtoryCoursesCursor cursor
		for select StudentID, CourseNum, Passed from Registration;
        
	declare done bool default false;
    
    declare continue handler for not found set done = true;
	
    drop table if exists SelectedCourses;
    create temporary table SelectedCourses (StudentID int(10), CourseNum char(10));
    
    open AddMandtoryCoursesCursor;
    
    a_loop: loop
		
        fetch AddMandtoryCoursesCursor into StudentID, CourseNum, Passed;
        
        declare a_courses;
        
        a_courses = select COUNT(*) from trackCourses where CourseNum = CourseNum AND mandatory = 1;
    
		if a_courses == 0 then
			insert into SelectedCourses values (StudentID, CourseNum);
            
		if done then
			leave a_loop;
	end loop;
    
    select * from SelectedCourses;
end //

delimiter ;

call AddMandtoryCourses();