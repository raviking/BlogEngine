USE [BlogEngine]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePost]    Script Date: 12/7/2017 8:43:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja swayampu>
-- Create date: <Create Date,7-dec-2017>
-- Description:	<Description,to delete post>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeletePost]
	@postId			bigint=0
AS
BEGIN	

    DELETE from Post where PostId=@postId
END
