

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,22-dec-2017>
-- Description:	<Description,deletes tag by id>
-- =============================================

-- Exec sp_DeleteTagByTagId 1

CREATE PROCEDURE [dbo].[sp_DeleteTagByTagId]
	@tagId bigint=0
AS
BEGIN

	DELETE from Tag where TagId=@tagId
END 



----------------------------------------------------------------------------------------

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets tag by tagid>
-- =============================================

-- Exec sp_GetTagByTagId 1

ALTER PROCEDURE [dbo].[sp_GetTagByTagId]
	@tagId bigint=0
AS
BEGIN
	SET NOCOUNT ON;
	declare @PostCount int;
	set @PostCount=null;
	select TagId,TagName,TagUrlSlug,TagDescription,@PostCount as PostCount from Tag where TagId=@tagId
END 

-----------------------------------------------------------------------------------


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Saves or updates Tag>
-- =============================================

-- Exec sp_AddorUpdateTag 'tagname','tagurlslug','tagdescription'

CREATE PROCEDURE [dbo].[sp_AddorUpdateTag]
	@tagId			bigint=0,
	@tagName		nvarchar(100)=null,
	@tagUrlSlug		nvarchar(100)=null,
	@tagDescription nvarchar(225)=null
AS
BEGIN
	IF(@tagId<>0 AND @tagId is not null)
	BEGIN
		UPDATE Tag SET TagName=@tagName,TagUrlSlug=@tagUrlSlug,TagDescription=@tagDescription where TagId=@tagId		
	END
	ELSE
	BEGIN
		INSERT INTO Tag(TagName,TagUrlSlug,TagDescription) VALUES(@tagName,@tagUrlSlug,@tagDescription)		
	END
END 



-----------------------------------------------------------------------------------------------------


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,8-nov-2017>
-- Description:	<Description,Gets all Tags>
-- =============================================

-- Exec sp_GetAllTags 

ALTER PROCEDURE [dbo].[sp_GetAllTags]

AS
BEGIN
	
	SET NOCOUNT ON;

	select T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription,(select COUNT(PostId) from PostTagMap where TagId=T.TagId) as PostCount from Tag T
END


-----------------------------------------------------------------------------------



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

-- Exec sp_GetTagByTagSlug 'afksfksd-sdfkjsdf-sdfjks'

ALTER PROCEDURE [dbo].[sp_GetTagByTagSlug]
	@tagSlug nvarchar(225)=null
AS
BEGIN
	SET NOCOUNT ON;

	select T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription,(select COUNT(PostId) from PostTagMap where TagId=T.TagId) as PostCount from Tag T 
	where T.TagUrlSlug=@tagSlug
END



-------------------------------------------------------------------------------------


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Saves or updates Category>
-- =============================================

-- Exec sp_AddorUpdateCategory 'category_name','category_urlslug','category_description'

CREATE PROCEDURE [dbo].[sp_AddorUpdateCategory]
	@categoryId				bigint=0,
	@categoryName			nvarchar(100)=null,
	@categoryUrlSlug		nvarchar(100)=null,
	@categoryDescription	nvarchar(225)=null
AS
BEGIN
	IF(@categoryId<>0 AND @categoryId is not null)
	BEGIN
		UPDATE Category SET CategoryName=@categoryName,CategoryUrlSlug=@categoryUrlSlug,CategoryDescription=@categoryDescription where CategoryId=@categoryId		
	END
	ELSE
	BEGIN
		INSERT INTO Category(CategoryName,CategoryUrlSlug,CategoryDescription) VALUES(@categoryName,@categoryUrlSlug,@categoryDescription)		
	END
END 


----------------------------------------------------------------------------------------------


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,22-dec-2017>
-- Description:	<Description,Deletes category bu id>
-- =============================================

-- Exec sp_DeleteCategoryById '1'

CREATE PROCEDURE [dbo].[sp_DeleteCategoryById]
	@categoryId bigint=0
AS
BEGIN
	
	DELETE from Category where CategoryId=@categoryId
	
END


---------------------------------------------------------------------



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,9-nov-2017>
-- Description:	<Description,Get Current user>
-- =============================================

-- Exec sp_GetCurrentUser 'ravi','welcome'

ALTER PROCEDURE [dbo].[sp_GetCurrentUser]
	@userId bigint=0,
	@userName nvarchar(100)=null,
	@password nvarchar(100)=null
AS
BEGIN
	
	SET NOCOUNT ON;

	IF(@userId>0)
	
	BEGIN
		select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email from Users U inner join Roles R on R.RoleId=U.Role
		where U.UserId=@userId
	END
	ELSE
	BEGIN
		select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email from Users U inner join Roles R on R.RoleId=U.Role
		where U.UserName=@userName and U.Password=@password
	END
END