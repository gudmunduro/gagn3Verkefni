use 1404002030_progresstracker_v1;

-- ********************** -- Skrifi� eftirfarandi stored procedures: --**********************

-- 1:	CourseList()
-- Birtir lista(yfirlit) af �llum �f�ngum sem geymdir eru � gagnagrunninum.
-- �fangarnir eru birtir � stafr�fsr�� 

drop procedure if exists CourseList;

delimiter //

create procedure CourseList()
begin
	select courseName, courseNumber from Courses order by courseName;
end //
delimiter ;

call CourseList();

-- 2:	SingleCourse()
-- 	Birtir uppl�singar um einn �kve�in k�rs.
--  F�ribreytan er �fangan�meri�

drop procedure if exists SingleCourse;

delimiter //

create procedure SingleCourse(courseNum char(10))
begin
	select courseName, courseNumber, courseCredits from Courses where courseNumber = courseNum;
end //
delimiter ;

call SingleCourse("EÐL103");

-- 3:   NewCourse()
--  N�skr�ir �fanga � gagnagrunninn.
--  Sko�i� ERD myndina til a� finna �t hva�a g�gn � a� vista(hva�a f�ribreytur � a� nota)
--  NewCourse er me� out parameterinn number_of_inserted_rows sem skilar fj�lda �eirra
--  ra�a sem vista�ar voru � gagnagrunninum.  Til �ess noti� �i� MySQL function: row_count()

drop procedure if exists NewCourse;

delimiter //

create procedure NewCourse(c_num CHAR(10), c_name VARCHAR(75), c_credits TINYINT(4), out number_of_inserted_rows INT(5))
begin
	SET @r_count = row_count();
	insert into Courses (courseNumber, courseName, courseCredits) values (c_num, c_name, c_credits);
    SET number_of_inserted_rows = row_count() - @r_count;
end //
delimiter ;

call NewCourse("FORR703", "Forritun", 3, @number_of_inserted_rows);

-- 4:	UpdateCourse()
--  H�r eru nota�ar s�mu f�ribreytur og � li� 3.  �fangan�meri� er nota� til a� uppf�ra r�ttan k�rs.alter
-- row_count( falli� er h�r nota� l�ka.

drop procedure if exists UpdateCourse;

delimiter //

create procedure UpdateCourse(c_num CHAR(10), c_name VARCHAR(75), c_credits TINYINT(4), out number_of_inserted_rows INT(5))
begin
	SET @r_count = row_count();
	
    update Courses set courseName = c_name, courseCredits = c_credits where courseNumber = c_num;
    
    SET number_of_inserted_rows = row_count() - @r_count;
end //
delimiter ;

call UpdateCourse("FORR703", "Forritun", 4, @number_of_inserted_rows);


-- 5:	DeleteCourse()
-- �fangan�mer(courseNumber) er nota� h�rna til a� ey�a r�ttum k�rs.
-- ATH: Ef veri� er a� nota k�rsinn einhverssta�ar(s� hann skr��ur � TrackCourses) �� m� EKKI ey�a honum.
-- S� hins vegar hvergi veri� a� nota hann m� ey�a honum �r Courses t�flunni og einnig Restrictors t�flunni.alter
-- sem fyrr er out parameter nota�ur til a� "skila" fj�lda �eirra ra�a sem eytt var �r t�flunni COurses

drop procedure if exists DeleteCourse;

delimiter //

create procedure DeleteCourse(c_num CHAR(10))
begin
	SET @r_count = row_count();
	
    delete from Courses where c_num = courseNumber;
    
    SET number_of_deleted_rows = row_count() - @r_count;
end //
delimiter ;

call DeleteCourse("FORR703", @number_of_deleted_rows);

-- ********************** -- Skrifi� eftirfarandi functions: --**********************

-- 6:	NumberOfCourses()
-- falli� skilar heildarfj�lda allra �fanga � grunninum


-- 7:	TotalTRackCredits()
--  Falli� skilar heildar einingafj�lda �kve�innar n�msbrautar(track)
--  Senda �arf trackID inn sem f�ribreytu


-- 8:   HighestCredits()
-- Falli� skilar einingafj�lda �ess n�mskei�s(�eirra n�mskei�a) sem hafa flestar eininar.
-- ATH:  �a� geta fleiri en einn k�rs veri� me� sama einingafj�ldann. :a� � ekki a� hafa 
-- �hfri � ni�urst��una.


-- 9:  TopTracksDivision()
-- Falli� skila� toppfj�lda n�msbrauta(tracks) sem tilheyra n�msbrautum(Divisions)

-- 10:  leastRestrictedCourseNumber()
-- Falli� skilar minnsta fj�lda k�rsa � Restrictors t�flunni.
-- ATH:  Ef k�rs e�a k�rsar eru t.d. me� einn undanfara �og ekkert meir �� myndi falli� skila 1 
