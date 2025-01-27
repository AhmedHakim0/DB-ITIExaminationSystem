-- Omnia 
--------------------
-- 1. Department 
Create Table Department
(dept_Id int primary key identity,
dept_Name varchar(25) unique,
mngr_Id int )

-- 2. Branches	
Create Table Branch
(br_Id int primary key identity,
br_Name varchar(25) unique, 
br_Location varchar(100),
br_phone varchar(25),
mngr_Id int
)
-- 3. BrancheDepratments
create table BrancheDepartments
(br_Id int foreign key references Branch(br_Id),
dept_Id int foreign key references Department(dept_Id),
constraint Branch_Dept_PK primary key (br_Id, dept_Id) 
)
-- 4. Tracks
create Table Track
(trk_Id int primary key identity, 
trk_Name varchar(25),
Dept_Id int foreign key references Department(dept_Id)
)

-----------------------------------

-- Reyad
---------------------
-- 5. Instructor

-- 6. Student 

-- 7. Courses

-- 8. CourseTracks

-- 9. CousreInstructors

----------------------------------------

-- Hakim
------------------------


-- 10. CourseStudents
create table CourseStudents
(crs_Id int foreign key references Courses(crs_id),
st_Id int foreign key references Students(st_id),
degree tinyint ,
constraint pk_crs_stu primary key (crs_id, st_id))

create procedure CourseStudentsInsert
@crs_id int,
@st_id int,
@degree int
as
insert into CourseStudents values (@crs_id, @st_id, @degree)


create procedure CousreStudentsUpdate
@old_crs_id int,
@old_st_id int,
@new_crs_id int,
@new_st_id int,
@degree int
as 
update CourseStudents 
set crs_Id = @new_crs_id, st_Id = @new_st_id, degree = @degree
where crs_Id = @old_crs_id and st_Id = @old_st_id

create procedure CourseStudentsDelete
@crs_id int,
@st_id int
as
delete from CourseStudents 
where crs_Id = @crs_id and st_Id = @st_id

create procedure CourseStudentsSelect
as
select * from CourseStudents

-- 11 QuestionType
create table QuestionType
(T_Id int primary key identity, 
q_Type varchar(25)) 

create proc QuestionTypeInsert
@q_Type varchar(25)
as
insert into QuestionType (q_Type) values (@q_Type)

create proc QuestionTypeUpdate
@T_Id int, 
@q_Type varchar(25)
as
update QuestionType set q_Type = @q_Type where T_Id = @T_Id

create proc QuestionTypeDelete
@T_Id int
as
delete from QuestionType where T_Id = @T_Id

create proc QuestionTypeSelect
as
select * from QuestionType 

-- 12. Questions
create table Question
(q_Id int primary key identity,
crs_Id int foreign key references Courses(crs_Id),
q_Type int foreign key references QuestionType(T_Id),
q_Body text)

create proc QuestionInsert
@crs_id int, 
@q_Type int,
@q_Body text
as
insert into Question (crs_Id, q_Type, q_Body)
values (@crs_id, @q_Type, @q_Body)

create proc QuestionUpdate
@q_Id int,
@crs_id int, 
@q_Type int,
@q_Body text
as
update Question set crs_Id = @crs_id, q_Type = @q_Type,
q_Body = @q_Body
where q_Id = @q_Id

create proc QuestionDelete
@q_Id int
as
delete from Question 
where q_Id = @q_Id

create proc QuestionSelect
as
select * from Question 


-- 13. Choices
create table Choices
(choice_Id int primary key identity,
q_Id int foreign key references Question(q_Id),
choiceText text,
isCorrect bit)

create proc ChoicesInsert
@q_id int, 
@choiceText text,
@isCorrect bit
as
insert into Choices(q_id, choiceText, isCorrect)
values (@q_id, @choiceText, @isCorrect)

create proc ChoicesUpdate
@choice_Id int,
@q_id int, 
@choiceText text,
@isCorrect bit
as
update Choices 
set q_id = @q_id, choiceText = @choiceText, 
	isCorrect = @isCorrect
where choice_Id = @choice_Id

create proc ChoicesDelete
@choice_Id int
as
delete from Choices 
where choice_Id = @choice_Id

create proc ChoicesSelect
as
select * from Choices 

------------------------------------------

-- Abdallah 
------------------------
-- 14. Exam Type
create Table ExamType
(T_Id int primary key identity,
TypeText varchar(25))

create proc ExamTypeInsert 
@typeText varchar(25)
as
insert into ExamType(TypeText) values (@typeText)

create proc ExamTypeUpdate
@t_Id int, 
@typeText varchar(25)
as
update ExamType set TypeText = @typeText
where T_Id = @t_Id

create proc ExamTypeDelete
@t_Id int
as
delete from ExamType 
where T_Id = @t_Id

create proc ExamTypeSelect
as
select * from ExamType 

-- 15. Exams
create table Exam 
(exam_Id int primary key Identity,
inst_Id int foreign key references Instructors(inst_Id),
exam_Type int foreign key references ExamType(T_Id),
crs_Id int foreign key references Courses(crs_id), 
br_Id int foreign key references Branch(br_Id),
trk_Id int foreign key references Track(trk_id),
exam_Date date,
exam_Duration int)

create proc ExamInsert
@inst_Id int,
@exam_Type int ,
@crs_Id int , 
@br_Id int,
@trk_Id int,
@exam_Date date,
@exam_Duration int
as
insert into 
Exam(inst_Id, exam_Type, crs_Id, br_Id, trk_Id, exam_Date, exam_Duration)
values(@inst_Id, @exam_Type, @crs_Id, @br_Id, @trk_Id, @exam_Date, @exam_Duration)


create proc ExamUpdate
@exam_Id int,
@inst_Id int,
@exam_Type int ,
@crs_Id int , 
@br_Id int,
@trk_Id int,
@exam_Date date,
@exam_Duration int
as
update Exam
set inst_Id = @inst_Id, exam_Type = @exam_Type,
crs_Id = @crs_Id, br_Id = @br_Id, trk_Id = @trk_Id,
exam_Date = @exam_Date, exam_Duration = @exam_Duration
where exam_Id = @exam_Id

create proc ExamDelete
@exam_Id int
as
delete from Exam
where exam_Id = @exam_Id

create proc ExamSelect
as
select * from Exam

-- 16. ExamQuestions
create table ExamQuestions
(exam_Id int foreign key references Exam(exam_id),
q_id int foreign key references question(q_id),
q_marks tinyint,
constraint pk_exam_questions primary key(exam_id, q_id))

create proc ExamQuestionsInsert
@exam_Id int,
@q_Id int, 
@q_marks tinyint
as
insert into ExamQuestions values (@exam_Id, @q_Id, @q_marks)

create proc ExamQuestionsUpdate
@old_exam_Id int, 
@old_q_Id int,
@new_exam_Id int,
@new_q_Id int, 
@q_marks tinyint
as
update ExamQuestions 
set exam_Id =  @new_exam_Id, 
q_id = @new_exam_Id, q_marks = @q_marks
where exam_Id = @old_exam_Id and q_id = @old_q_Id

create proc ExamQuestionsDelete
@exam_Id int, 
@q_Id int
as
delete from ExamQuestions 
where exam_Id = @exam_Id and q_id = @q_Id

create proc ExamQuestionsSelect
as
select * from ExamQuestions

-- 17. StudentAnswers

create table StudentAnswers
(st_Id int foreign key references Students(st_id),
exam_Id int foreign key references Exam(exam_Id),
q_id int foreign key references Question(q_id),
st_answer int foreign key references Choices(choice_id),
constraint pk_stuAnswer primary key (st_Id, exam_Id, q_id, st_answer))

create proc StudentAnswersInsert
@st_Id int,
@exam_Id int,
@q_id int,
@st_answer int 
as
insert into StudentAnswers values 
(@st_Id, @exam_Id, @q_id, @st_answer)


create proc StudentAnswersUpdate
@old_st_Id int,
@old_exam_Id int,
@old_q_id int,
@old_st_answer int,
@new_st_Id int,
@new_exam_Id int,
@new_q_id int,
@new_st_answer int 
as
update StudentAnswers  
set st_id = @new_st_Id, exam_Id = @new_exam_Id,
q_id = @new_q_id, st_answer = @new_st_answer
where st_id = @old_st_Id and exam_Id = @old_exam_Id and
q_id = @old_q_id and st_answer = @old_st_answer

create proc StudentAnswersDelete
@st_Id int,
@exam_Id int,
@q_id int,
@st_answer int 
as
delete from StudentAnswers 
where st_Id = @st_Id and exam_Id =  @exam_Id
and q_id = @q_id and st_answer = @st_answer

create proc StudentAnswersSelect
as
select * from StudentAnswers

-- 18. StudentExmas
create table StudentExams
(st_Id int foreign key references Students(st_id),
exam_id int foreign key references Exam(exam_id),
degree int,
constraint pk_stu_exam primary key (st_id, exam_id)
)

create proc StudentExamsInsert
@st_Id int,
@exam_Id int ,
@degree int
as
insert into StudentExams 
values (@st_Id, @exam_Id, @degree)

create proc StudentExamsUpdate
@old_st_Id int,
@old_exam_Id int ,
@new_st_Id int,
@new_exam_Id int ,
@degree int
as
update StudentExams
set st_Id = @new_exam_Id, exam_id = @new_exam_Id, 
degree = @degree 
where st_Id = @old_exam_Id and exam_id = @old_exam_Id

create proc StudentExamsDelete
@st_Id int,
@exam_Id int 
as
delete from StudentExams
where st_Id = @exam_Id and exam_id = @exam_Id

create proc StudentExamsSelect
as
select *  from StudentExams
