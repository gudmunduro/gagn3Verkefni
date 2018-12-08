use 1404002030_progresstracker_v1;
select * from TrackCourses;
select * from Divisions;

# 1

drop procedure if exists TrackOverview;

delimiter //

create procedure TrackOverview(trackID INT(10))
begin
	set @courseCount = (select count(*) from Courses);
	select Tracks.trackName, count(Courses.courseNumber), count(Courses.courseNumber) / @courseCount * 100 as '%' from
    Tracks inner join TrackCourses on TrackCourses.trackID = Tracks.trackID
    inner join Courses on TrackCourses.courseNumber = Courses.courseNumber where Tracks.trackID = trackID;
end //

delimiter ;
    
call TrackOverview(3);

# 2

drop procedure if exists TrackTotalCredits;

delimiter //

create procedure TrackTotalCredits()
begin
	select Tracks.trackName, Divisions.divisionName, count(Courses.courseNumber) from Tracks 
    inner join Divisions on Divisions.divisionID = Tracks.divisionID
    inner join TrackCourses on Tracks.trackID = TrackCourses.trackID
    inner join Courses on TrackCourses.courseNumber = Courses.courseNumber
    order by count(Courses.courseNumber);
end //

delimiter ;
    
call TrackTotalCredits();

# 3

drop procedure if exists CourseRestrictorList;

delimiter //

create procedure CourseRestrictorList()
begin
	select Courses.courseName, Restrictors.restrictorID, Restrictors.restrictorType from Courses 
    inner join Restrictors on Courses.courseNumber = Restrictors.courseNumber;
end //

delimiter ;
    
call CourseRestrictorList();

# 4

drop procedure if exists RestrictorList;

delimiter //

create procedure RestrictorList()
begin
	select Restrictors.restrictorID, Restrictors.restrictorType, Courses.courseName from Restrictors 
    inner join Courses on Courses.courseNumber = Restrictors.courseNumber;
end //

delimiter ;
    
call RestrictorList();
