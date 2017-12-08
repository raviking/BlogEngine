
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets tag by tagslug>
-- =============================================

-- Exec sp_GetTagByTagSlug 'csharp'

ALTER PROCEDURE [dbo].[sp_GetTagByTagSlug]
	@tagSlug nvarchar(225)=null
AS
BEGIN
	SET NOCOUNT ON;

	select T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription,Count(P.PostId) as PostCount 
	from Tag T inner join PostTagMap PTM on PTM.TagId=T.TagId
	inner join Post P on P.PostId=PTM.PostId where T.TagUrlSlug=@tagSlug group by T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription
END
