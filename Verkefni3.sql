use 1404002030_progresstracker_v1;

# Gömul útgáfa.  Gat ekki náð í nýja því þetta tækniskólaský virkar eiginlega aldrei.  Mun skipta á mánudaginn

# 1

delimiter &&

drop procedure if exists SemesterInfo &&

create procedure SemesterInfo()
begin
/*
	select JSON_OBJECTAGG(
			"Nafn", studentName
            "DOB", "",
            "Áfangar", select JSON_OBJECTAGG(
				"Áfangi", CONCAT(courseNumber)
            ) as Áfangar from courses
    ) as Nemendur from students;
    */
    select * from students;
end &&



delimiter ;

call SemesterInfo();

select version();
