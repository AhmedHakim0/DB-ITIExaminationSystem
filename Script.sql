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

-- 11 QuestionType
create table QuestionType
(T_Id int primary key identity, 
q_Type varchar(25)) 
-- 12. Questions
create table Question
(q_Id int primary key identity,
crs_Id int foreign key references Courses(crs_Id),
q_Type int foreign key references QuestionType(T_Id),
q_Body text)

-- 13. Choices
create table Choices
(choice_Id int primary key identity,
q_Id int foreign key references Question(q_Id),
choiceText text,
isCorrect bit)

------------------------------------------

-- Abdallah 
------------------------
-- 14. Exam Type
create Table ExamType
(T_Id int primary key identity,
TypeText varchar(25))
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

-- 16. ExamQuestions
create table ExamQuestions
(exam_Id int foreign key references Exam(exam_id),
q_id int foreign key references question(q_id),
q_marks tinyint,
constraint pk_exam_questions primary key(exam_id, q_id))

-- 17. StudentAnswers
create table StudentAnswers
(stu_Id int foreign key references Students(st_id),
exam_Id int foreign key references Exam(exam_Id),
q_id int foreign key references Question(q_id),
stu_answer int foreign key references Choices(choice_id),
constraint pk_stuAnswer primary key (stu_Id, exam_Id, q_id, stu_answer))
-- 18. StudentExmas
create table StudentExams
(st_Id int foreign key references Students(st_id),
exam_id int foreign key references Exam(exam_id),
degree int,
constraint pk_stu_exam primary key (st_id, exam_id)
) 