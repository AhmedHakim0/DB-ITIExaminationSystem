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

----------------------------------------

-- Hakim
------------------------

-- 9. CousreInstructors

-- 10. CourseStudents

-- 11. Questions

-- 12. Choices

------------------------------------------

-- Abdallah 
------------------------
-- 13. Exams

-- 14. ExamQuestions

-- 15. StudentAnswers

-- 16. StudentExmas