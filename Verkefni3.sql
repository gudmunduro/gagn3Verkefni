use 1404002030_progresstracker_v1;

# 1

delimiter &&

drop procedure if exists SemesterInfo &&

create procedure SemesterInfo()
begin    
    select group_concat("{", 
    (select concat('"nafn": "', studentName, '",', '"DOB": "7. Janúar. 1997', '", "Áfangar": [', (select group_concat('"', courseNumber, '", ') from trackcourses where trackcourses.trackID = Students1.trackID), ']')
    from students where students.studentID = Students1.studentID)
    ,"}") as JsonData from students as Students1;
    
end &&



delimiter ;

call SemesterInfo();

# 2

alter table schools add schoolInfo json;

update schools set schoolInfo = JSON_OBJECT("name", "Tækniskólinn", "addresstype", "multiple", "address", JSON_ARRAY("Skólavörðuholti(Aðalbygging)", "Skólavörðuholt", "Flatahrauni", "Háteigsvegi"), "cost", "20200" ) where schoolID = 1;

insert into schools (schoolName, schoolInfo) values ("Borgarholtsskóli", JSON_OBJECT("name", "Borgarholtsskóli", "addresstype", "single", "address", "Mosavegi", "cost", "12600"));

insert into schools (schoolName, schoolInfo) values ("Fjölbrautaskólinn við Ármúla", JSON_OBJECT("name", "Fjölbrautaskólinn við ármúla", "addresstype", "single", "address", "Ármúla 12", "cost", "18000"));

delimiter &&

drop procedure if exists GetAllSchoolInfo &&

create procedure GetAllSchoolInfo(id int(10))
begin    
    select schoolInfo from schools where schoolID = id;
end &&

delimiter ;

call GetAllSchoolInfo(4);
