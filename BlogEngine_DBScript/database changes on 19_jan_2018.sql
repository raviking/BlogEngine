

GO
/****** Object:  StoredProcedure [dbo].[sp_SavePostDetails]    Script Date: 1/19/2018 1:33:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC sp_SavePostDetails 26,'test title1','test_post desc','postmeta','posturlslug',true,null,null,1,null,101,1,1,null,'1,2,3'
ALTER PROCEDURE [dbo].[sp_SavePostDetails]
	@postId				bigint=0,
	@title				nvarchar(max)=null,
	@postDescription	nvarchar(max)=null,
	@postMeta			nvarchar(250)=null,
	@postUrlSlug		nvarchar(250)=null,
	@isPublished		bit,
	@postedOn			datetime=null,
	@modifiedDate		datetime=null,
	@createdBy			bigint=0,
	@createdDate		datetime=null,
	@postStatus			int=0,
	@categoryId			bigint=0,
	@userId				bigint=0,
	@modifiedBy			nvarchar(225)=null,
	@tagString			nvarchar(50)=null
AS
BEGIN
	DECLARE @tagRecords AS TABLE (ID INT IDENTITY(1,1),tId INT) --temp table
	-- inserting data into temp table 
		INSERT INTO @tagRecords(tId)   
		SELECT * FROM Split(@tagString,',') 
	DECLARE @id bigint 
	DECLARE @count int set @count=1
	DECLARE @tagCount int

	SET @tagCount=(SELECT COUNT(*) FROM @tagRecords)	

	IF(@postId is not null and @postId<>0)
	BEGIN
		UPDATE Post set Title=@title,PostDescription=@postDescription,PostMeta=@postMeta,PostUrlSlug=@postUrlSlug,IsPublished=@isPublished,
				ModifiedDate=@modifiedDate,PostStatus=@postStatus,CategoryId=@categoryId,ModifiedBy=@modifiedBy where PostId=@postId
		
		IF(@tagCount>0)		
		BEGIN		
			DELETE FROM PostTagMap where PostId=@postId
			WHILE (@count<=@tagCount)
			BEGIN				
				INSERT into PostTagMap(PostId,TagId) values(@postId,(select tId from @tagRecords where Id=@count))
				SET @count=@count+1
			END
		END
	END
	ELSE
	BEGIN		
		INSERT into Post(Title,PostDescription,PostMeta,PostUrlSlug,IsPublished,PostedOn,CreatedBy,CreatedDate,PostStatus,CategoryId,UserId)
				VALUES(@title,@postDescription,@postMeta,@postUrlSlug,@isPublished,@postedOn,@createdBy,@createdDate,@postStatus,@categoryId,@userId)						
		SET @id=SCOPE_IDENTITY()			  					
		IF(@tagCount>0)
		BEGIN		
			WHILE (@count<=@tagCount)
			BEGIN				
				INSERT into PostTagMap(PostId,TagId) values(@id,(select tId from @tagRecords where Id=@count))
				SET @count=@count+1
			END
		END
	END
END




------------------------------------------------------------------------------------------------------------


