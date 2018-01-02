
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,2-jan-2018>
-- Description:	<Description,Deletes comment by comment id>
-- =============================================
CREATE PROCEDURE sp_DeleteComment 
	@commentId		bigint=0
AS
BEGIN
	DELETE from Comments where Comment_Id=@commentId
END
GO


----------------------------------------------------------------

