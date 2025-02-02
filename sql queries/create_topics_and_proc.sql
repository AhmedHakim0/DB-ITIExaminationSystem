use ITIExaminationSystem
CREATE TABLE topics (
    topic_id INT IDENTITY PRIMARY KEY,
    topic_name varchar(50),
    crs_id INT FOREIGN KEY REFERENCES Courses(crs_id)
);
ALTER TABLE students 
ADD track_id INT, 
    branch_id INT;

ALTER TABLE students 
ADD CONSTRAINT FK_students_tracks 
FOREIGN KEY (track_id) REFERENCES track(trk_Id),

CONSTRAINT FK_students_branches
FOREIGN KEY (branch_id) REFERENCES branch(br_Id);


-- topics procuders
-- insert
create proc TopicInsert
@Topic_Name int,
@Crs_Id int 
as
begin
	if exists (select * from Topic where Topic_Name = @Topic_Name and Crs_Id = @Crs_Id)
		select 'This Topic Is Already Exist In This Course!' as message;
	else
	begin
		insert into Topic (Topic_Name, Crs_Id)
		values (@Topic_Name, @Crs_Id)
	end
end

-- update
create proc TopicUpdate
@Topic_Id int,
@Topic_Name int,
@Crs_Id int 
as
begin
	if not exists (select Topic_Id from Topic where Topic_Id = @Topic_Id)
		select 'This Topic Is Not Found' as message; 
	else if exists (select * from Topic where Topic_Name = @Topic_Name and Crs_Id = @Crs_Id and Topic_Id != @Topic_Id)
		select 'This Topic Is Already Exist In This Course!' as message;
	else
	begin
		update Topic 
		set Topic_Name = @Topic_Name, Crs_Id = @crs_Id
		where Topic_Id = @Topic_Id
	end
end

 -- delete
create proc TopicDelete
@Topic_Id int
as
begin 
	if not exists (select Topic_Id from Topic where Topic_Id = @Topic_Id)
		select 'This Topic Is Not Found' as message; 
	else
	begin 
		delete from Topic where Topic_Id = @Topic_Id
	end
end

-- select
create proc TopicSelectAll
as
select * from Topic

-- select one
create proc TopicSelectOne
@Topic_Id int
as
begin 
	if not exists (select Topic_Id from Topic where Topic_Id = @Topic_Id)
			select 'This Topic Is Not Found' as message;
	else 
		select * from Topic where Topic_Id = @Topic_Id
end





