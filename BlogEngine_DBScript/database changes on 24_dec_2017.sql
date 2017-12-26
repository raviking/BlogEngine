
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,24-dec-2017>
-- Description:	<Description,Deletes user by userid>
-- =============================================
CREATE PROCEDURE sp_DeleteUser
	@userId		bigint=0
AS
BEGIN
    
	DELETE from Users where UserId=@userId
END
GO



create table Comments
(
	Comment_Id				bigint not null primary key identity(1,1),
	Comment_Content			nvarchar(max) not null,
	Comment_Approved		bit not null,
	Comment_Date			Datetime not null,
	Comment_Author			nvarchar(50) not null,
	Comment_AuthorEmail		nvarchar(100) not null,
	Comment_Parent			bigint,
	Comment_PostId			bigint foreign key references Post(PostId),
	UserId					bigint
)



USE [BlogEngine]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllComments]    Script Date: 12/25/2017 8:03:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,24-dec-2017>
-- Description:	<Description,Get all comments>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetAllComments] 
AS
BEGIN	
	SET NOCOUNT ON;

    SELECT C.Comment_Id,C.Comment_Content,C.Comment_Approved,C.Comment_Date,C.Comment_Author,C.Comment_AuthorEmail,C.Comment_Parent,
	C.Comment_PostId,C.UserId,(select Title from Post where PostId=C.Comment_PostId) as PostName from Comments C
END