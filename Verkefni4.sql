use 1404002030_progresstracker_v1;

# Schools

delimiter &&

drop procedure if exists createSchool &&

create procedure createSchool(id int(11), schoolName varchar(75))
begin
	insert into Schools(schoolID, schoolName) values (id, schoolName);
end &&

delimiter ;
delimiter &&

drop procedure if exists selectSchool &&

create procedure selectSchool(id int(11))
begin
	select * from schools where schoolID = id;
end &&

delimiter ;
delimiter &&

drop procedure if exists deleteSchool &&

create procedure deleteSchool(id int(11))
begin
	delete from schools where schoolID = id;
end &&

delimiter ;
delimiter &&

drop procedure if exists changeSchoolValue &&

create procedure changeSchoolValue(id int(11), valueToChange varchar(10), changeTo varchar(75))
begin
	update schools set schoolName = changeTo where schoolID = id;
end &&

delimiter ;
delimiter &&

drop procedure if exists getAllSchools &&

create procedure getAllSchools()
begin
	select * from schools;
end &&

delimiter ;




# Student

delimiter &&

drop procedure if exists createStudent &&

create procedure createStudent(studentName varchar(50), credits int(4), trackID int(11))
begin
	insert into students (studentName, credits, trackID) values (studentName, credits, trackID);
end &&

delimiter ;
delimiter &&

drop procedure if exists selectStudent &&

create procedure selectStudent(id int(11))
begin
	select * from students where studentID = id;
end &&

delimiter ;
delimiter &&

drop procedure if exists deleteStudent &&

create procedure deleteStudent(id int(11))
begin
	delete from students where studentID = id;
end &&

delimiter ;
delimiter &&

drop procedure if exists changeStudentValue &&

create procedure changeStudentValue(id int(11), valueToChange varchar(10), changeTo varchar(50))
begin
	CASE valueToChange
		WHEN "credits" THEN update students set credits = changeTo * 1 where studentID = id;
        WHEN "trackID" THEN update students set trackID = changeTo *1 where studentID = id;
		WHEN "studentName" THEN update students set studentName = changeTo where studentID = id;
	END CASE;
end &&

delimiter ;
delimiter &&

drop procedure if exists getAllStudents &&

create procedure getAllStudents()
begin
	select * from students;
end &&

delimiter ;





# Course

delimiter &&

drop procedure if exists createCourse &&

create procedure createCourse(courseNumber char(10), courseName varchar(75), courseCredits tinyint(4))
begin
	insert into courses (courseNumber, courseName, courseCredits) values (courseNumber, courseName, courseCredits);
end &&

delimiter ;
delimiter &&

drop procedure if exists selectCourse &&

create procedure selectCourse(courseNumber char(10))
begin
	select * from courses where courseNumber = courseNumber;
end &&

delimiter ;
delimiter &&

drop procedure if exists deleteCourse &&

create procedure deleteCourse(courseNumber char(10))
begin
	delete from courses where courseNumber = courseNumber;
end &&

delimiter ;
delimiter &&

drop procedure if exists changeCourseValue &&

create procedure changeCourseValue(courseNumber char(10), valueToChange varchar(10), changeTo varchar(50))
begin
	CASE valueToChange
		WHEN "courseNumber" THEN update courses set courseNumber = changeTo where courseNumber = courseNumber;
        WHEN "courseName" THEN update courses set courseName = changeTo where courseNumber = courseNumber;
		WHEN "courseCredits" THEN update courses set courseCredits = changeTo * 1 where courseNumber = courseNumber;
	END CASE;
end &&

delimiter ;
delimiter &&

drop procedure if exists getAllCourses &&

create procedure getAllCourses()
begin
	select * from courses;
end &&

delimiter ;
