

--- changes done on 30-dec-2017



GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComment]    Script Date: 12/31/2017 9:57:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,30-dec-2017>
-- Description:	<Description,Saves user comment>
-- =============================================
ALTER PROCEDURE [dbo].[sp_SaveComment]
	@comment_Id				bigint=0,
	@comment_Content		nvarchar(max)=null,
	@comment_Date			datetime=null,
	@comment_Author			nvarchar(100)=null,
	@Comment_AuthorEmail	nvarchar(100)=null,
	@Comment_Parent			bigint=0,
	@Comment_Approved		bit,
	@Comment_PostId			bigint=0
AS
BEGIN
	INSERT into Comments(Comment_Content,Comment_Date,Comment_Author,Comment_AuthorEmail,Comment_Parent,Comment_Approved,Comment_PostId)
	VALUES(@comment_Content,@comment_Date,@comment_Author,@Comment_AuthorEmail,@Comment_Parent,@Comment_Approved,@Comment_PostId)
END


