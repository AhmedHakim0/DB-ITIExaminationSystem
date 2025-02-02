use ITIExaminationSystem
--3
CREATE PROCEDURE GetInstructorCoursesWithStudentCount2
    @InstructorID INT
AS
BEGIN
    SELECT 
        c.crs_Name AS CourseName,
        COUNT(sc.st_Id) AS StudentCount
    FROM 
        Courses c
    INNER JOIN CourseInstructors ic ON c.crs_id = ic.course_id
    LEFT JOIN CourseStudents sc ON c.crs_id = sc.crs_id
    WHERE 
        ic.Instructor_id = @InstructorID
    GROUP BY 
        c.crs_Name
    ORDER BY 
        c.crs_Name;
END

EXEC GetInstructorCoursesWithStudentCount2 @InstructorID = 2;

--insert into CourseInstructors values(3,2);
--2
CREATE PROCEDURE GetStudentGrades 
    @StudentID INT
AS
BEGIN
    SELECT 
        s.st_id, 
        s.st_fname, 
        c.crs_Name, 
        cs.degree AS Grade
    FROM Students s
    JOIN CourseStudents cs ON s.st_id = cs.st_id
    JOIN Courses c ON cs.crs_id = c.crs_Id
    WHERE s.st_id = @StudentID;
END;

EXEC GetStudentGrades @StudentID = 1;
--1
CREATE PROCEDURE GetStudentsByDepartment
    @DepartmentNo INT
AS
BEGIN
    SELECT 
        s.st_id, 
        s.st_fname, 
		s.st_lname,
		s.st_Email,
		s.st_phone,
        s.dept_id,
        d.dept_Name
    FROM Students s
    JOIN Department d ON s.dept_id = d.dept_Id
    WHERE s.dept_id = @DepartmentNo;
END;

EXEC GetStudentsByDepartment @DepartmentNo = 2;

-- 4
CREATE PROCEDURE CourseTopic
    @Crs_Id INT
AS
BEGIN
    SELECT Topic_Name FROM Topic WHERE Crs_Id = @Crs_Id;
END

EXEC CourseTopic @Crs_Id = 6;

--5
create proc ExamQuestionReport(@examid int)
as
begin
	select q.q_Body,
	q.q_marks
	from exam e 
	join ExamQuestions qe
	on e.exam_Id=qe.Exam_id and e.exam_Id=@examid
	join Question q
	on q.q_Id=qe.Q_id
end

EXEC ExamQuestionReport @examid = 2;
--6
CREATE PROCEDURE StudentExamDetailsReport
    @ExamID INT,
    @StudentID INT
AS
BEGIN
    SELECT 
        s.st_id, 
        s.st_fname + ' ' + s.st_lname AS StudentName, 
        q.q_body, 
        c.choicetext
    FROM Students s
    JOIN StudentAnswers sa ON s.st_id = sa.st_id
    JOIN Question q ON sa.q_id = q.q_id
    JOIN Choices c ON q.q_id = c.q_id
    WHERE sa.exam_id = @ExamID AND sa.st_id = @StudentID And sa.st_answer = c.choice_Id;
END;

EXEC StudentExamDetailsReport @ExamID = 2, @StudentID = 1;



