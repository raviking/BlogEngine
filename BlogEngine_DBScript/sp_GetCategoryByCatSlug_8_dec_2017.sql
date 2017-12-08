
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets Category by Category UrlSlug>
-- =============================================

-- Exec sp_GetCategoryByCatSlug 'first-ategory'

CREATE PROCEDURE [dbo].[sp_GetCategoryByCatSlug]
	@categoryUrlSlug nvarchar(225)=null
AS
BEGIN
	
	SET NOCOUNT ON;

	select C.CategoryId,C.CategoryName,C.CategoryUrlSlug,C.CategoryDescription,
	(select count(postId) from Post where CategoryId=C.CategoryId) as postcount
	 from Category C where C.CategoryUrlSlug=@categoryUrlSlug
END
