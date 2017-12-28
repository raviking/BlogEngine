
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,28-dec-2017>
-- Description:	<Description,Get all comments by postid>
-- =============================================

-- exec sp_GetCommentsByPostId 1

ALTER PROCEDURE sp_GetCommentsByPostId
	@postId		bigint=0
AS
BEGIN
	
	SET NOCOUNT ON;
    
	SELECT Comment_Id,Comment_Content,Comment_Approved,Comment_Date,Comment_Author,Comment_AuthorEmail,Comment_Parent
	,Comment_PostId,UserId from Comments where Comment_PostId=@postId
END
GO
