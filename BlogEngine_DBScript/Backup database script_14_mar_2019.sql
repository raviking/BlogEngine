USE [master]
GO
/****** Object:  Database [BlogEngine]    Script Date: 3/14/2019 6:27:32 PM ******/
CREATE DATABASE [BlogEngine] ON  PRIMARY 
( NAME = N'BlogEngine', FILENAME = N'D:\GitHub\BlogEngineMVC\BlogEngine\BlogEngine_DB\BlogEngine.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BlogEngine_log', FILENAME = N'D:\GitHub\BlogEngineMVC\BlogEngine\BlogEngine_DB\BlogEngine_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BlogEngine] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlogEngine].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlogEngine] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlogEngine] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlogEngine] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlogEngine] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlogEngine] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlogEngine] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BlogEngine] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BlogEngine] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlogEngine] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlogEngine] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlogEngine] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlogEngine] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlogEngine] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlogEngine] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlogEngine] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlogEngine] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BlogEngine] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlogEngine] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlogEngine] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlogEngine] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlogEngine] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlogEngine] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BlogEngine] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlogEngine] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BlogEngine] SET  MULTI_USER 
GO
ALTER DATABASE [BlogEngine] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlogEngine] SET DB_CHAINING OFF 
GO
USE [BlogEngine]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddorUpdateCategory]    Script Date: 3/14/2019 6:27:33 PM ******/
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
GO
/****** Object:  StoredProcedure [dbo].[sp_AddorUpdateTag]    Script Date: 3/14/2019 6:27:33 PM ******/
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

GO
/****** Object:  StoredProcedure [dbo].[sp_AddorUpdateUser]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,26/02/2019>
-- Description:	<Description,To Add or Update the user details>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddorUpdateUser]
	@userId			int=0,
	@firstName		nvarchar(100),
	@lastName		nvarchar(100),
	@userName		nvarchar(100),
	@password		nvarchar(100),
	@role			int=0,
	@userStatus		int=0,
	@gender			nvarchar(100),
	@email			nvarchar(100),
	@country		int=0,
	@designation	nvarchar(100)
AS
BEGIN	
	IF(@userId>0 AND @userId IS NOT NULL)
	BEGIN
		UPDATE Users SET FirstName=@firstName,LastName=@lastName,UserName=@userName,Password=@password,Role=@role,UserStatus=@userStatus,
		Gender=@gender,Country=@country,Designation=@designation,Email=@email where UserId=@userId
	END
	ELSE
	BEGIN
		INSERT INTO Users(FirstName,LastName,UserName,Password,Role,UserStatus,Gender,Country,Designation,RegistrationDate,Email)
		VALUES(@firstName,@lastName,@userName,@password,@role,@userStatus,@gender,@country,@designation,GETDATE(),@email)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCategoryById]    Script Date: 3/14/2019 6:27:33 PM ******/
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
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteComment]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,3-jan-2018>
-- Description:	<Description,Deletes comment by comment id>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteComment] 
	@commentId		bigint=0
AS
BEGIN
	DELETE from Comments where Comment_Id=@commentId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePost]    Script Date: 3/14/2019 6:27:33 PM ******/
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
	DELETE from PostTagMap where PostId=@postId
    DELETE from Post where PostId=@postId
	DELETE from Comments where Comment_PostId=@postId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteTagByTagId]    Script Date: 3/14/2019 6:27:33 PM ******/
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

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUser]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,24-dec-2017>
-- Description:	<Description,Deletes user by userid>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteUser]
	@userId		bigint=0
AS
BEGIN
    
	DELETE from Users where UserId=@userId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllCategories]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,8-nov-2017>
-- Description:	<Description,Gets all categories>
-- =============================================

-- Exec sp_GetAllCategories '1'

CREATE PROCEDURE [dbo].[sp_GetAllCategories]

AS
BEGIN
	
	SET NOCOUNT ON;

	select C.CategoryId,C.CategoryName,C.CategoryUrlSlug,C.CategoryDescription,
	(select count(postId) from Post where CategoryId=C.CategoryId) as postcount
	 from Category C
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllComments]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,24-dec-2017>
-- Description:	<Description,Get all comments>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllComments] 
AS
BEGIN	
	SET NOCOUNT ON;

    SELECT C.Comment_Id,C.Comment_Content,C.Comment_Date,C.Comment_Author,C.Comment_AuthorEmail,
	C.Comment_PostId,C.IsReply from Comments C
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllCountries]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Raviteja Swayampu>
-- Create date: <Create Date,7_dec_2017>
-- Description:	<Description,To fill country dropdowns>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllCountries]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT ID,CountryName FROM Country
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllPosts]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,KrishnaVamsi Gudivada>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets all posts with category and tags data>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllPosts]
AS
BEGIN
	SET NOCOUNT ON;

    select p.postid,p.title,p.postdescription,p.postmeta,p.posturlslug,p.ispublished,p.postedon,p.createdby,
	p.createddate,p.poststatus,p.ModifiedBy,p.ModifiedDate,p.CategoryId,p.UserId
	from post p inner join category c on c.categoryid=p.categoryid
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllRoles]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,14-nov-2017>
-- Description:	<Description,Gets all roles from database>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllRoles]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RoleId,RoleName,RoleDescription from Roles
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllTags]    Script Date: 3/14/2019 6:27:33 PM ******/
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

CREATE PROCEDURE [dbo].[sp_GetAllTags]

AS
BEGIN
	
	SET NOCOUNT ON;

	select T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription,(select COUNT(PostId) from PostTagMap where TagId=T.TagId) as PostCount from Tag T
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllUserDetails]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,3-nov-2017>
-- Description:	<Description,To get all user details>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllUserDetails]
AS
BEGIN
	SET NOCOUNT ON;
	
	select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,U.Country,U.Designation,
	U.RegistrationDate,U.Email,(select count(PostId) from Post where UserId=U.UserId) as PostCount
	from Users U inner join Roles R on R.RoleId=U.Role

END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategoryByCatSlug]    Script Date: 3/14/2019 6:27:33 PM ******/
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

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategoryById]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets Category by Category UrlSlug>
-- =============================================

-- Exec sp_GetCategoryById '1'

CREATE PROCEDURE [dbo].[sp_GetCategoryById]
	@categoryId bigint=0
AS
BEGIN
	
	SET NOCOUNT ON;

	select C.CategoryId,C.CategoryName,C.CategoryUrlSlug,C.CategoryDescription,
	(select count(postId) from Post where CategoryId=C.CategoryId) as postcount
	 from Category C where C.CategoryId=@categoryId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCommentsByPostId]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,24-dec-2017>
-- Description:	<Description,Get all comments by post id>
-- =============================================

-- EXEC sp_GetCommentsByPostId 1

CREATE PROCEDURE [dbo].[sp_GetCommentsByPostId]
	@postId		bigint=0
AS
BEGIN
	SET NOCOUNT ON;

     SELECT C.Comment_Id,C.Comment_Content,C.Comment_Date,C.Comment_Author,C.Comment_AuthorEmail,
	C.Comment_PostId,C.IsReply from Comments C where C.Comment_PostId=@postId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCurrentUser]    Script Date: 3/14/2019 6:27:33 PM ******/
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

CREATE PROCEDURE [dbo].[sp_GetCurrentUser]
	@userId bigint=0,
	@userName nvarchar(100)=null,
	@password nvarchar(100)=null
AS
BEGIN
	
	SET NOCOUNT ON;

	IF(@userId>0 AND @userId IS NOT NULL)
	
	BEGIN
		select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email,(Select count(PostId) from Post where UserId=@userId) as PostCount from Users U 
		inner join Roles R on R.RoleId=U.Role		
		where U.UserId=@userId group by U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email
	END
	ELSE
	BEGIN
		select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email,(Select count(PostId) from Post where UserId=@userId) as PostCount from Users U
		inner join Roles R on R.RoleId=U.Role		
		where U.UserName=@userName and U.Password=@password group by U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostIdByUrlSlug]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,29-nov-2017>
-- Description:	<Description,To get postid by postUrlSlug>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPostIdByUrlSlug]
	@postUrlSlug nvarchar(100)=0
AS
BEGIN	

	SELECT PostId FROM Post where PostUrlSlug=@postUrlSlug
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByCategory]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets posts based  on categoryid>
-- =============================================

-- Exec sp_GetPostsByCategory 1

CREATE PROCEDURE [dbo].[sp_GetPostsByCategory] 
	@categoryId bigint=0
AS
BEGIN
	SET NOCOUNT ON;

    select p.postid,p.title,p.postdescription,p.postmeta,p.posturlslug,p.ispublished,p.postedon,p.createdby,
	p.createddate,p.poststatus,p.ModifiedBy,p.ModifiedDate,p.CategoryId,p.UserId
	from post p inner join category c on c.categoryid=p.categoryid
	where c.CategoryId=@categoryId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByCategorySlug]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets posts based  on categoryid>
-- =============================================

-- Exec sp_GetPostsByCategorySlug 1

CREATE PROCEDURE [dbo].[sp_GetPostsByCategorySlug] 
	@categorySlug nvarchar(50)=0
AS
BEGIN
	SET NOCOUNT ON;

    select p.postid,p.title,p.postdescription,p.postmeta,p.posturlslug,p.ispublished,p.postedon,p.createdby,
	p.createddate,p.poststatus,p.ModifiedBy,p.ModifiedDate,p.CategoryId,p.UserId
	from post p inner join category c on c.categoryid=p.categoryid
	where c.CategoryUrlSlug=@categorySlug
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByPostId]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,8-nov-2017>
-- Description:	<Description,Gets all posts based on PostId>
-- =============================================

-- Exec sp_GetPostsByPostId '1'

CREATE PROCEDURE [dbo].[sp_GetPostsByPostId] 
	@postId bigint=0
AS
BEGIN

	SET NOCOUNT ON;

	SELECT postid,title,postdescription,postmeta,posturlslug,ispublished,postedon,createdby,
	createddate,poststatus,ModifiedBy,ModifiedDate,CategoryId,UserId
	from post where PostId=@postId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByPostUrlSlug]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,8-nov-2017>
-- Description:	<Description,Gets all posts based on PostUrlSlug>
-- =============================================

-- Exec sp_GetPostsByPostUrlSlug '1'

CREATE PROCEDURE [dbo].[sp_GetPostsByPostUrlSlug] 
	@postUrlSlug nvarchar(100)=0
AS
BEGIN

	SET NOCOUNT ON;

	SELECT postid,title,postdescription,postmeta,posturlslug,ispublished,postedon,createdby,
	createddate,poststatus,ModifiedBy,ModifiedDate,CategoryId,UserId
	from post where PostUrlSlug=@postUrlSlug
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsBySearch]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets all posts based on search text>
-- =============================================

-- Exec sp_GetPostsBySearch 'Javasc'

CREATE PROCEDURE [dbo].[sp_GetPostsBySearch] 
	@searchText nvarchar(100)=null
AS
BEGIN

	SET NOCOUNT ON;

	SELECT postid,title,postdescription,postmeta,posturlslug,ispublished,postedon,createdby,
	createddate,poststatus,ModifiedBy,ModifiedDate,CategoryId,UserId
	from post where Title like '%'+@searchText+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByTagId]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets all posts based on tag>
-- =============================================

-- Exec sp_GetPostsByTagSlug 'html'

CREATE PROCEDURE [dbo].[sp_GetPostsByTagId]
	@tagId bigint=0
AS
BEGIN
	SET NOCOUNT ON

	 select p.postid,p.title,p.postdescription,p.postmeta,p.posturlslug,p.ispublished,p.postedon,p.createdby,
		p.createddate,p.poststatus,p.ModifiedBy,p.ModifiedDate,p.CategoryId,p.UserId
		from post p inner join PostTagMap PTM on PTM.PostId=p.PostId inner join Tag t on t.TagId=PTM.TagId
		where t.TagId=@tagId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByTagSlug]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets all posts based on tag slug>
-- =============================================

-- Exec sp_GetPostsByTagSlug 'html'

CREATE PROCEDURE [dbo].[sp_GetPostsByTagSlug]
	@tagSlug nvarchar(50)=null
AS
BEGIN
	SET NOCOUNT ON

	 select p.postid,p.title,p.postdescription,p.postmeta,p.posturlslug,p.ispublished,p.postedon,p.createdby,
		p.createddate,p.poststatus,p.ModifiedBy,p.ModifiedDate,p.CategoryId,p.UserId
		from post p inner join PostTagMap PTM on PTM.PostId=p.PostId inner join Tag t on t.TagId=PTM.TagId
		where t.TagUrlSlug=@tagSlug
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostsByUserId]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,10-nov-2017>
-- Description:	<Description,Gets all posts based on UserId>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPostsByUserId]
	@userId bigint=0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT postid,title,postdescription,postmeta,posturlslug,ispublished,postedon,createdby,
	createddate,poststatus,ModifiedBy,ModifiedDate,CategoryId,Userid from Post where UserId=@userId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPreAndNextPosts]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,14-mar-2019>
-- Description:	<Description,To get previous and next postId's of selected Post>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPreAndNextPosts] 
	@postId		bigint=0
AS
BEGIN
	DECLARE @previousPostId bigint
	SET @previousPostId=(select MAX(PostId) from Post where PostId<@postId and IsPublished=1)
	DECLARE @nextPostId bigint
	SET @nextPostId=(select min(PostId) from Post where PostId>@postId and IsPublished=1)

	select @postId as PostId,
			(select Title from Post where PostId=@previousPostId) as PreviousPostTitle,
			(select PostUrlSlug from Post where PostId=@previousPostId) as PreviousPostUrlSlug,
			(select Title from Post where PostId=@nextPostId) as NextPostTitle,
			(select PostUrlSlug from Post where PostId=@nextPostId) as NextPostUrlSlug
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetReplyForComment]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetReplyForComment]
	@CommentId	bigint=0
AS
BEGIN
	SELECT ReplyId,Reply_Content,Reply_Author,Reply_CoommentId,Reply_Date from Reply where Reply_CoommentId=@CommentId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetTagByTagId]    Script Date: 3/14/2019 6:27:33 PM ******/
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

CREATE PROCEDURE [dbo].[sp_GetTagByTagId]
	@tagId bigint=0
AS
BEGIN
	SET NOCOUNT ON;
	declare @PostCount int;
	set @PostCount=null;
	select TagId,TagName,TagUrlSlug,TagDescription,@PostCount as PostCount from Tag where TagId=@tagId
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTagByTagSlug]    Script Date: 3/14/2019 6:27:33 PM ******/
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

CREATE PROCEDURE [dbo].[sp_GetTagByTagSlug]
	@tagSlug nvarchar(225)=null
AS
BEGIN
	SET NOCOUNT ON;

	select T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription,(select COUNT(PostId) from PostTagMap where TagId=T.TagId) as PostCount from Tag T 
	where T.TagUrlSlug=@tagSlug
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetTagsByPostId]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,7-nov-2017>
-- Description:	<Description,Gets all tag names based on postid>
-- =============================================

-- Exec sp_GetTagsByPostId 1

CREATE PROCEDURE [dbo].[sp_GetTagsByPostId]
	@postId bigint=0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription,Count(P.PostId) as PostCount from Tag T
	inner join PostTagMap PTM on PTM.TagId=T.TagId 
	inner join Post P on PTM.PostId=P.PostId where P.PostId=@postId group by T.TagId,T.TagName,T.TagUrlSlug,T.TagDescription
END

GO
/****** Object:  StoredProcedure [dbo].[sp_IsPostUrlSlugExists]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_IsPostUrlSlugExists]
	@postUrlSlug	nvarchar(225)=null
AS
BEGIN
	select * from Post where PostUrlSlug like '%'+@postUrlSlug+'%'
END

GO
/****** Object:  StoredProcedure [dbo].[sp_PublishPost]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PublishPost]
	@postId		bigint,
	@postedOn	datetime
AS
BEGIN
	UPDATE Post SET IsPublished=1,PostedOn=@postedOn where PostId=@postId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComment]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,30-dec-2017>
-- Description:	<Description,Saves user comment>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveComment]
	@comment_Id				bigint=0,
	@comment_Content		nvarchar(max)=null,
	@comment_Date			datetime=null,
	@comment_Author			nvarchar(100)=null,
	@Comment_AuthorEmail	nvarchar(100)=null,
	@Comment_PostId			bigint=0
AS
BEGIN
	INSERT into Comments(Comment_Content,Comment_Date,Comment_Author,Comment_AuthorEmail,Comment_PostId,IsReply)
	VALUES(@comment_Content,@comment_Date,@comment_Author,@Comment_AuthorEmail,@Comment_PostId,0)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComment_Reply]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveComment_Reply]
	@ReplyId		bigint=0,
	@ReplyContent	nvarchar(max),
	@ReplyDate		datetime,
	@ReplyAuthor	nvarchar(50),
	@ReplyCommentId	bigint=0
AS
BEGIN
	insert into Reply(Reply_Content,Reply_Date,Reply_Author,Reply_CoommentId) values(@ReplyContent,@ReplyDate,@ReplyAuthor,@ReplyCommentId)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SavePostDetails]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC sp_SavePostDetails 26,'test title1','test_post desc','postmeta','posturlslug',true,null,null,1,null,101,1,1,null,'1,2,3'
CREATE PROCEDURE [dbo].[sp_SavePostDetails]
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
		SELECT @id 
	END
END


GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split](@String nvarchar(max), @Delimiter char(1))  
RETURNS @Results TABLE (Items nvarchar(max))  
AS  
    BEGIN  
    DECLARE @INDEX INT  
    DECLARE @SLICE nvarchar(max)  
    -- HAVE TO SET TO 1 SO IT DOESNT EQUAL Z  
    --     ERO FIRST TIME IN LOOP  
    SELECT @INDEX = 1  
    WHILE @INDEX !=0  
  
  
        BEGIN   
         -- GET THE INDEX OF THE FIRST OCCURENCE OF THE SPLIT CHARACTER  
         SELECT @INDEX = CHARINDEX(@Delimiter,@STRING)  
         -- NOW PUSH EVERYTHING TO THE LEFT OF IT INTO THE SLICE VARIABLE  
         IF @INDEX !=0  
          SELECT @SLICE = LEFT(@STRING,@INDEX - 1)  
         ELSE  
          SELECT @SLICE = @STRING  
         -- PUT THE ITEM INTO THE RESULTS SET  
         INSERT INTO @Results(Items) VALUES(@SLICE)  
         -- CHOP THE ITEM REMOVED OFF THE MAIN STRING  
         SELECT @STRING = RIGHT(@STRING,LEN(@STRING) - @INDEX)  
         -- BREAK OUT IF WE ARE DONE  
         IF LEN(@STRING) = 0 BREAK  
    END  
    RETURN  
END



--Ex:
--select items from dbo.split(columnname,',')
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](225) NOT NULL,
	[CategoryUrlSlug] [nvarchar](225) NOT NULL,
	[CategoryDescription] [nvarchar](225) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Comment_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Comment_Content] [nvarchar](max) NOT NULL,
	[Comment_Date] [datetime] NOT NULL,
	[Comment_Author] [nvarchar](50) NOT NULL,
	[Comment_AuthorEmail] [nvarchar](100) NOT NULL,
	[Comment_PostId] [bigint] NULL,
	[IsReply] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Comment_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Post]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[PostId] [bigint] IDENTITY(18,1) NOT NULL,
	[Title] [nvarchar](225) NOT NULL,
	[PostDescription] [nvarchar](max) NULL,
	[PostMeta] [nvarchar](max) NULL,
	[PostUrlSlug] [nvarchar](225) NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[PostedOn] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[PostStatus] [int] NULL,
	[CategoryId] [bigint] NULL,
	[UserId] [bigint] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostTagMap]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostTagMap](
	[PostId] [bigint] NOT NULL,
	[TagId] [bigint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reply]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reply](
	[ReplyId] [bigint] IDENTITY(1,1) NOT NULL,
	[Reply_Content] [nvarchar](max) NULL,
	[Reply_Date] [datetime] NULL,
	[Reply_Author] [nvarchar](50) NULL,
	[Reply_CoommentId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReplyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] NOT NULL,
	[RoleName] [nvarchar](30) NOT NULL,
	[RoleDescription] [nvarchar](225) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[TagId] [bigint] IDENTITY(1,1) NOT NULL,
	[TagName] [nvarchar](225) NOT NULL,
	[TagUrlSlug] [nvarchar](225) NOT NULL,
	[TagDescription] [nvarchar](225) NULL,
PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/14/2019 6:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Role] [int] NOT NULL,
	[UserStatus] [int] NULL,
	[Gender] [nvarchar](20) NULL,
	[Country] [int] NULL,
	[Designation] [nvarchar](100) NULL,
	[RegistrationDate] [datetime] NOT NULL,
	[Email] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Category] ON 

GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (1, N'First Category', N'first-ategory', N'this is first category buddy')
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (2, N'Programming', N'programming', NULL)
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (3, N'Humor', N'humor', NULL)
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (4, N'Sports', N'Sports', NULL)
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (5, N'Finance', N'Finance', NULL)
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (6, N'Blogging', N'Blogging', NULL)
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (8, N'TestCategory1', N'TestCategory1', N'kjd sf saifsiof esf sdiufsd fusidfsd jhshd uisd usdhj udssdf s')
GO
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [CategoryUrlSlug], [CategoryDescription]) VALUES (9, N'Mutual Funds', N'Mutual_Funds', N'')
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

GO
INSERT [dbo].[Comments] ([Comment_Id], [Comment_Content], [Comment_Date], [Comment_Author], [Comment_AuthorEmail], [Comment_PostId], [IsReply]) VALUES (1, N'This post is awesome man', CAST(0x0000A87B00000000 AS DateTime), N'Raviteja Swayampu', N'ravitejaswayampu@gmail.com', 1, 0)
GO
INSERT [dbo].[Comments] ([Comment_Id], [Comment_Content], [Comment_Date], [Comment_Author], [Comment_AuthorEmail], [Comment_PostId], [IsReply]) VALUES (3, N'some avinash comment buddy', CAST(0x0000A85C00A298E1 AS DateTime), N'Avinash Bodepudi', N'avimashbodepudi@gmail.com', 1, 0)
GO
INSERT [dbo].[Comments] ([Comment_Id], [Comment_Content], [Comment_Date], [Comment_Author], [Comment_AuthorEmail], [Comment_PostId], [IsReply]) VALUES (4, N'lk;fjsdlkf jsdsdgdhjgj', CAST(0x0000A9FA00F07787 AS DateTime), N'kjsdfkdj', N'sdjkfsdkg', 1, 0)
GO
INSERT [dbo].[Comments] ([Comment_Id], [Comment_Content], [Comment_Date], [Comment_Author], [Comment_AuthorEmail], [Comment_PostId], [IsReply]) VALUES (5, N'jdskfsd gsdbsfd', CAST(0x0000AA0B00000000 AS DateTime), N'Narasimha', N'narasimharao.swayampu@gmail.com', 8, 1)
GO
INSERT [dbo].[Comments] ([Comment_Id], [Comment_Content], [Comment_Date], [Comment_Author], [Comment_AuthorEmail], [Comment_PostId], [IsReply]) VALUES (6, N'Hi buddy good work...', CAST(0x0000AA1000DACCE6 AS DateTime), N'ramu', N'ramu@gmail.com', 15, 0)
GO
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (1, N'Afghanistan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (2, N'Albania')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (3, N'Algeria')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (4, N'American Samoa')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (5, N'Andorra')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (6, N'Angola')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (7, N'Anguilla')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (8, N'Antarctica')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (9, N'Antigua And Barbuda')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (10, N'Argentina')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (11, N'Armenia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (12, N'Aruba')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (13, N'Australia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (14, N'Austria')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (15, N'Azerbaijan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (16, N'Bahamas')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (17, N'Bahrain')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (18, N'Bangladesh')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (19, N'Barbados')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (20, N'Belarus')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (21, N'Belgium')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (22, N'Belize')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (23, N'Benin')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (24, N'Bermuda')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (25, N'Bhutan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (26, N'Bolivia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (27, N'Bosnia And Herzegowina')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (28, N'Botswana')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (29, N'Bouvet Island')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (30, N'Brazil')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (31, N'British Indian Ocean Territory')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (32, N'Brunei Darussalam')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (33, N'Bulgaria')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (34, N'Burkina Faso')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (35, N'Burundi')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (36, N'Cambodia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (37, N'Cameroon')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (38, N'Canada')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (39, N'Cape Verde')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (40, N'Cayman Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (41, N'Central African Republic')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (42, N'Chad')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (43, N'Chile')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (44, N'China')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (45, N'Christmas Island')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (46, N'Cocos (Keeling) Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (47, N'Colombia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (48, N'Comoros')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (49, N'Congo')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (50, N'Cook Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (51, N'Costa Rica')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (52, N'Cote D''Ivoire')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (53, N'Croatia (Local Name: Hrvatska)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (54, N'Cuba')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (55, N'Cyprus')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (56, N'Czech Republic')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (57, N'Denmark')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (58, N'Djibouti')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (59, N'Dominica')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (60, N'Dominican Republic')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (61, N'East Timor')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (62, N'Ecuador')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (63, N'Egypt')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (64, N'El Salvador')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (65, N'Equatorial Guinea')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (66, N'Eritrea')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (67, N'Estonia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (68, N'Ethiopia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (69, N'Falkland Islands (Malvinas)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (70, N'Faroe Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (71, N'Fiji')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (72, N'Finland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (73, N'France')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (74, N'French Guiana')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (75, N'French Polynesia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (76, N'French Southern Territories')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (77, N'Gabon')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (78, N'Gambia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (79, N'Georgia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (80, N'Germany')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (81, N'Ghana')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (82, N'Gibraltar')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (83, N'Greece')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (84, N'Greenland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (85, N'Grenada')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (86, N'Guadeloupe')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (87, N'Guam')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (88, N'Guatemala')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (89, N'Guinea')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (90, N'Guinea-Bissau')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (91, N'Guyana')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (92, N'Haiti')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (93, N'Heard And Mc Donald Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (94, N'Holy See (Vatican City State)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (95, N'Honduras')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (96, N'Hong Kong')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (97, N'Hungary')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (98, N'Iceland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (99, N'India')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (100, N'Indonesia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (101, N'Iran (Islamic Republic Of)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (102, N'Iraq')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (103, N'Ireland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (104, N'Israel')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (105, N'Italy')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (106, N'Jamaica')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (107, N'Japan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (108, N'Jordan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (109, N'Kazakhstan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (110, N'Kenya')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (111, N'Kiribati')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (112, N'Korea, Dem People''S Republic')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (113, N'Korea, Republic Of')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (114, N'Kuwait')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (115, N'Kyrgyzstan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (116, N'Lao People''S Dem Republic')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (117, N'Latvia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (118, N'Lebanon')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (119, N'Lesotho')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (120, N'Liberia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (121, N'Libyan Arab Jamahiriya')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (122, N'Liechtenstein')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (123, N'Lithuania')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (124, N'Luxembourg')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (125, N'Macau')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (126, N'Macedonia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (127, N'Madagascar')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (128, N'Malawi')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (129, N'Malaysia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (130, N'Maldives')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (131, N'Mali')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (132, N'Malta')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (133, N'Marshall Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (134, N'Martinique')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (135, N'Mauritania')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (136, N'Mauritius')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (137, N'Mayotte')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (138, N'Mexico')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (139, N'Micronesia, Federated States')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (140, N'Moldova, Republic Of')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (141, N'Monaco')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (142, N'Mongolia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (143, N'Montserrat')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (144, N'Morocco')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (145, N'Mozambique')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (146, N'Myanmar')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (147, N'Namibia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (148, N'Nauru')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (149, N'Nepal')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (150, N'Netherlands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (151, N'Netherlands Ant Illes')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (152, N'New Caledonia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (153, N'New Zealand')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (154, N'Nicaragua')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (155, N'Niger')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (156, N'Nigeria')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (157, N'Niue')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (158, N'Norfolk Island')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (159, N'Northern Mariana Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (160, N'Norway')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (161, N'Oman')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (162, N'Pakistan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (163, N'Palau')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (164, N'Panama')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (165, N'Papua New Guinea')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (166, N'Paraguay')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (167, N'Peru')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (168, N'Philippines')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (169, N'Pitcairn')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (170, N'Poland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (171, N'Portugal')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (172, N'Puerto Rico')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (173, N'Qatar')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (174, N'Reunion')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (175, N'Romania')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (176, N'Russian Federation')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (177, N'Rwanda')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (178, N'Saint K Itts And Nevis')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (179, N'Saint Lucia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (180, N'Saint Vincent, The Grenadines')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (181, N'Samoa')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (182, N'San Marino')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (183, N'Sao Tome And Principe')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (184, N'Saudi Arabia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (185, N'Senegal')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (186, N'Seychelles')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (187, N'Sierra Leone')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (188, N'Singapore')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (189, N'Slovakia (Slovak Republic)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (190, N'Slovenia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (191, N'Solomon Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (192, N'Somalia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (193, N'South Africa')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (194, N'South Georgia , S Sandwich Is.')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (195, N'Spain')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (196, N'Sri Lanka')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (197, N'St. Helena')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (198, N'St. Pierre And Miquelon')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (199, N'Sudan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (200, N'Suriname')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (201, N'Svalbard, Jan Mayen Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (202, N'Sw Aziland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (203, N'Sweden')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (204, N'Switzerland')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (205, N'Syrian Arab Republic')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (206, N'Taiwan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (207, N'Tajikistan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (208, N'Tanzania, United Republic Of')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (209, N'Thailand')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (210, N'Togo')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (211, N'Tokelau')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (212, N'Tonga')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (213, N'Trinidad And Tobago')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (214, N'Tunisia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (215, N'Turkey')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (216, N'Turkmenistan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (217, N'Turks And Caicos Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (218, N'Tuvalu')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (219, N'Uganda')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (220, N'Ukraine')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (221, N'United Arab Emirates')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (222, N'United Kingdom')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (223, N'United States')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (224, N'United States Minor Is.')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (225, N'Uruguay')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (226, N'Uzbekistan')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (227, N'Vanuatu')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (228, N'Venezuela')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (229, N'Viet Nam')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (230, N'Virgin Islands (British)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (231, N'Virgin Islands (U.S.)')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (232, N'Wallis And Futuna Islands')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (233, N'Western Sahara')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (234, N'Yemen')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (235, N'Yugoslavia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (236, N'Zaire')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (237, N'Zambia')
GO
INSERT [dbo].[Country] ([ID], [CountryName]) VALUES (238, N'Zimbabwe')
GO
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (1, N'My Mouse Is Missing', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'my_mouse_is_missing', 1, CAST(0x000091C401388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD54 AS DateTime), NULL, 1, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (3, N'I'' Genius', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'im_genius', 1, CAST(0x0000946201388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD5B AS DateTime), NULL, 1, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (6, N'My Coding Is Bad', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'Mi_coding_is_bad', 1, CAST(0x0000A2A801388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD5B AS DateTime), NULL, 1, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (7, N'I Like Steve', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p style="text-align: center;"><img src="http://localhost/BlogEngine/Media/Uploads/the_croods_characters-wallpaper-1366x768.jpg" alt="" width="632" height="355" /></p>', N'ASP', N'I-Like-Steve', 1, CAST(0x00008F2601388BBA AS DateTime), CAST(0x0000AA020120E4CC AS DateTime), NULL, CAST(0x0000A82400BCFD5C AS DateTime), 101, 1, 1, N'1')
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (8, N'This is Big image post buddy', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="http://localhost/BlogEngine/Media/Uploads/despicable_me_2_laughing_minions-wallpaper-1366x768.jpg" alt="" width="1000" height="562" /></div>
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'This post tells about how java script works', N'This-is-Big-image-post-buddy', 1, CAST(0x0000A31F01388BBA AS DateTime), CAST(0x0000AA06013B5F56 AS DateTime), NULL, CAST(0x0000A82400BCFD5C AS DateTime), 101, 2, 1, N'1')
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (10, N'Mobile Programming', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'Mobile_programming', 1, CAST(0x00009D7401388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD5C AS DateTime), NULL, 4, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (11, N'How To Create Blog', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'how_to_create_blog', 1, CAST(0x00009BFD01388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD5C AS DateTime), NULL, 5, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (12, N'Introduction To Agile', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'Introduction_to_Agile', 1, CAST(0x0000992201388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD5D AS DateTime), NULL, 6, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (13, N'HTML5 And CSS3', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>', N'ASP', N'Html5_and_css3', 1, CAST(0x000097F601388BBA AS DateTime), NULL, NULL, CAST(0x0000A82400BCFD5E AS DateTime), NULL, 1, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (15, N'Responsive Websites', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p style="text-align: center;">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.</p>
<p><img src="http://localhost/BlogEngine/Media/Uploads/minions_2015_movie-wallpaper-1366x768.jpg" alt="" width="737" height="414" /></p>', N'ASP', N'Responsive-Websites', 1, CAST(0x0000909301388BBA AS DateTime), CAST(0x0000AA0300B078F8 AS DateTime), NULL, CAST(0x0000A82400BCFD5E AS DateTime), 101, 3, 1, N'1')
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (32, N'testpostonebaby', N'<p>kjsdhfs sfh is s soifu sof sof os fs</p>
<p>sdf sdoif sdofso sfsdfsd sdf sdfs</p>', N'kjasfksdf sduf iuf sdfiusfhsa if siuf', N'testpostonebaby', 0, CAST(0x0000AA0A00FB2C43 AS DateTime), CAST(0x0000AA0A00FD78F2 AS DateTime), 1, CAST(0x0000AA0A00F9ACA0 AS DateTime), 101, 5, 1, N'1')
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (38, N'Introduction to Mutual Funds', N'<p>A mutual fund is a professionally managed investment fund that pools money from many investors to purchase securities. These investors may be retail or institutional in nature.</p>
<p>Mutual funds have advantages and disadvantages compared to direct investing in individual securities. The primary advantages of mutual funds are that they provide economies of scale, a higher level of diversification, they provide liquidity, and they are managed by professional investors. On the negative side, investors in a mutual fund must pay various fees and expenses.</p>
<p>Primary structures of mutual funds include open-end funds, unit investment trusts, and closed-end funds. Exchange-traded funds (ETFs) are open-end funds or unit investment trusts that trade on an exchange. Mutual funds are also classified by their principal investments as money market funds, bond or fixed income funds, stock or equity funds, hybrid funds or other. Funds may also be categorized as index funds, which are passively managed funds that match the performance of an index, or actively managed funds. Hedge funds are not mutual funds; hedge funds cannot be sold to the general public and are subject to different government regulations.</p>
<div><img style="display: block; margin-left: auto; margin-right: auto;" src="http://localhost/BlogEngine/Media/Uploads/steve_jobs-wallpaper-1366x768.jpg" alt="" width="1000" height="562" /></div>
<p>In the United States, mutual funds play an important role in U.S. household finances. At the end of 2016, 22% of household financial assets were held in mutual funds. Their role in retirement savings was even more significant, since mutual funds accounted for roughly half of the assets in individual retirement accounts, 401(k)s and other similar retirement plans.[7]&nbsp;In total, mutual funds are large investors in stocks and bonds.</p>
<p>Luxembourg and Ireland are the primary jurisdictions for the registration of&nbsp;UCITS&nbsp;funds. These funds may be sold throughout the European Union and in other countries that have adopted mutual recognition regimes.</p>
<p><strong>Advantages</strong></p>
<ul style="list-style-type: circle;">
<li>Increased diversification: A fund diversifies holding many securities. This diversification decreases risk.</li>
<li>Daily liquidity: Shareholders of open-end funds and unit investment trusts may sell their holdings back to the fund at regular intervals at a price equal to the net asset value of the fund''s holdings. Most funds allow investors to redeem in this way at the close of every trading day.</li>
<li>Professional investment management: Open-and closed-end funds hire portfolio managers to supervise the fund''s investments.</li>
<li>Ability to participate in investments that may be available only to larger investors. For example, individual investors often find it difficult to invest directly in foreign markets.</li>
<li>Service and convenience: Funds often provide services such as check writing.</li>
<li>Government oversight: Mutual funds are regulated by a governmental body.</li>
<li>Transparency and ease of comparison: All mutual funds are required to report the same information to investors, which makes them easier to compare to each other.</li>
</ul>
<p><strong>Disadvantages</strong></p>
<p>Mutual funds have disadvantages as well, which include:</p>
<ul style="list-style-type: circle;">
<li>Fees.</li>
<li>Less control over timing of recognition of gains.</li>
<li>Less predictable income.</li>
<li>No opportunity to customize.</li>
</ul>
<p><strong>Mutual funds today</strong></p>
<p>At the end of 2016, mutual fund assets worldwide were $40.4 trillion, according to the Investment Company Institute.[6] The countries with the largest mutual fund industries are:</p>
<ol>
<li>United States: $18.9 trillion</li>
<li>Luxembourg: $3.9 trillion</li>
<li>Ireland: $2.2 trillion</li>
<li>Germany: $1.9 trillion</li>
<li>France: $1.9 trillion</li>
<li>Australia: $1.6 trillion</li>
<li>United Kingdom: $1.5 trillion</li>
<li>Japan: $1.5 trillion</li>
<li>China: $1.3 trillion</li>
<li>Brazil: $1.1 trillion</li>
</ol>
<p>In the United States, mutual funds play an important role in U.S. household finances. At the end of 2016, 22% of household financial assets were held in mutual funds. Their role in retirement savings was even more significant, since mutual funds accounted for roughly half of the assets in individual retirement accounts, 401(k)s and other similar retirement plans.[7]&nbsp;In total, mutual funds are large investors in stocks and bonds.</p>
<p>Luxembourg and Ireland are the primary jurisdictions for the registration of&nbsp;UCITS&nbsp;funds. These funds may be sold throughout the European Union and in other countries that have adopted mutual recognition regimes.</p>', N'A mutual fund is a professionally managed investment fund that pools money from many investors to purchase securities. These investors may be retail or institutional in nature.We will get a brief idea about Mutual funds in India advantages and Disadv', N'Introduction-to-Mutual-Funds', 1, CAST(0x0000AA0F00DD8AA9 AS DateTime), NULL, 1, CAST(0x0000AA0F00D996D4 AS DateTime), 101, 9, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (39, N'TEstPost buddy', N'<p>jlsdfkj sfe</p>
<p>sfskl sd flsk s</p>
<p>sf sdilfsoidjs</p>
<p>''sf posifpsofsfsd&nbsp; hlgu</p>
<p>g</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>', N'jnkfksf sa osid fosjf iosdpofsdjifjsdi fsdi foisd fih sf osdfjosdiosid ifjiosd fjios fisd jfiosjn fweuigjer sj safuidsd fsd iuds sd dkbniug dghbg dio fsfbsuidfsidofhsfbsm b kjfhskfh sufhuidsfh sdfkfhjfbsdfiugvbd dsfisjfidjfiodfid  efsdsdg dfgdfh gjh ', N'TEstPost-buddy', 0, NULL, NULL, 1, CAST(0x0000AA0F01094DAD AS DateTime), 101, 6, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (40, N'test title3', N'test_post desc', N'postmeta', N'posturlslug', 0, CAST(0x0000AA0500000000 AS DateTime), NULL, 1, CAST(0x0000AA0500000000 AS DateTime), 101, 1, 1, NULL)
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (41, N'Test baby test baby', N'<p>hfghfghfghfg fg hgfhf</p>
<p>gfh fgh fghf</p>
<p>ghgf</p>
<p>hfgh</p>
<p>sdfsdfsdsdgdsgsdgsdgsdgsdgsd</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://localhost/BlogEngine/Media/Uploads/registration-page-using-asp.net-mvc-mitechdev.com.jpeg.png" alt="" width="494" height="442" /></p>', N'j  asjds fpsdof soif osidfjoifios fsoidf sd fshf isud usdgyfosdyf sdf dsif i sfiu sdyf usduyfgs dfsid fiysdgu s fgs fggsif gsyufs yyu suygsduygufg sfugsfug euegyg euygyasfgdsuyg e fe fuygefuywg efyg fufywefuygegf uweuy fgweuy fgwe wef we', N'Test-baby-test-baby', 1, NULL, CAST(0x0000AA1000F0BD79 AS DateTime), 1, CAST(0x0000AA0F010C592C AS DateTime), 101, 6, 1, N'1')
GO
INSERT [dbo].[Post] ([PostId], [Title], [PostDescription], [PostMeta], [PostUrlSlug], [IsPublished], [PostedOn], [ModifiedDate], [CreatedBy], [CreatedDate], [PostStatus], [CategoryId], [UserId], [ModifiedBy]) VALUES (42, N'TEstPost buddydfgdfgfd', N'<p>gfd gdfg df gd dfg d</p>
<p>fg fdgh ui esh 9oisd fsi fjiosdag</p>
<p>&nbsp;dsg idfsgu09ofdgrdfr yj&nbsp;</p>', N'jhgas du asiudh ai dsu hsa fsgyd 76wihu ka iohseo fhaiu fdhkw egh87f jhge yfewiuhioaufeh ioeh9o haskuh dsiuafh9sagbf uwekf8uiweg fhe fuiehiuehKuashfs esyesdy htdhfy t a yey 5 y yr rt', N'TEstPost-buddydfgdfgfd', 1, CAST(0x0000AA0F011C55E4 AS DateTime), NULL, 1, CAST(0x0000AA0F011B03E7 AS DateTime), 101, 6, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (1, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (1, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (38, 17)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (3, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (3, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (7, 3)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (7, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (15, 2)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (15, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (6, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (6, 3)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (8, 5)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (8, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (39, 16)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (40, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (41, 16)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (10, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (10, 3)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (11, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (11, 3)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (12, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (12, 2)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (13, 1)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (1, 4)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (1, 6)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (42, 16)
GO
INSERT [dbo].[PostTagMap] ([PostId], [TagId]) VALUES (32, 6)
GO
SET IDENTITY_INSERT [dbo].[Reply] ON 

GO
INSERT [dbo].[Reply] ([ReplyId], [Reply_Content], [Reply_Date], [Reply_Author], [Reply_CoommentId]) VALUES (1, N'Hi buddy jkfks ksds sdkfbiufkbi', CAST(0x0000AA0D00A05F42 AS DateTime), N'Raviteja', 5)
GO
SET IDENTITY_INSERT [dbo].[Reply] OFF
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription]) VALUES (1, N'ADMIN', N'ADMIN')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription]) VALUES (2, N'EDITOR', N'EDITOR')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription]) VALUES (3, N'AUTHOR', N'AUTHOR')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription]) VALUES (4, N'SUBSCRIBER', N'SUBSCRIBER')
GO
SET IDENTITY_INSERT [dbo].[Tag] ON 

GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (1, N'CSharp', N'csharp', NULL)
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (2, N'ASP NET MVC', N'asp-net-mvc', N'asp.net mvc application')
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (3, N'ASP.NET', N'asp_net', NULL)
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (4, N'JavaScript', N'javascript', NULL)
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (5, N'Silverlight', N'silverlight', NULL)
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (6, N'Html', N'html', NULL)
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (7, N'Css', N'css', NULL)
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (16, N'ASP Classic', N'asp-classic', N'classical asp')
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [TagUrlSlug], [TagDescription]) VALUES (17, N'Money Management', N'Money_Management', N'')
GO
SET IDENTITY_INSERT [dbo].[Tag] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (1, N'Raviteja', N'Swayampu', N'ravi', N'welcome', 1, 101, N'Male', 99, N'Web Developer', CAST(0x0000A82000000000 AS DateTime), N'ravitejaswayampu@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (2, N'Sridhar', N'Thota', N'sri596', N'welcome', 2, 101, N'Male', 99, N'Developer', CAST(0x0000A82800000000 AS DateTime), N'sreedhar596@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (3, N'Avinash', N'Bodepudi', N'minnabhai', N'welcome', 3, 101, N'Male', 99, N'Tester', CAST(0x0000A70E00000000 AS DateTime), N'avinash.bodepudi@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (4, N'Anu', N'Vaka', N'anu', N'welcome', 2, 101, N'Female', 1, N'Content Developer', CAST(0x0000A72B00000000 AS DateTime), N'ananya.goldenfish@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (9, N'shekar', N'borra', N'shekar', N'welcome', 4, 101, N'MALE', 99, N'nothing', CAST(0x0000AA0000BFFE3B AS DateTime), N'shekar.borra@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (10, N'hema', N'sagar', N'sagar', N'welcome', 4, 101, N'MALE', 99, N'nothing', CAST(0x0000AA0000C0E470 AS DateTime), N'hemasagar@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (11, N'Ravi', N'teja', N'', N'', 4, 101, N'', 99, N'', CAST(0x0000AA0D0128FA3E AS DateTime), N'ravi.swayampu123@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (12, N'Ranjit', N'Pasham', N'', N'', 4, 101, N'', 98, N'', CAST(0x0000AA0D012A26AE AS DateTime), N'ranjit.pasham@gmail.com')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [Role], [UserStatus], [Gender], [Country], [Designation], [RegistrationDate], [Email]) VALUES (13, N'kljsfkj', N'kjhsdskj', N'', N'', 4, 101, N'', 99, N'', CAST(0x0000AA0D012B6B24 AS DateTime), N'jsdfbskjg@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__tmp_ms_x__7CEA93FD1BC821DD]    Script Date: 3/14/2019 6:27:33 PM ******/
ALTER TABLE [dbo].[Post] ADD UNIQUE NONCLUSTERED 
(
	[PostUrlSlug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([Comment_PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PostTagMap]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostTagMap]  WITH CHECK ADD FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([TagId])
GO
USE [master]
GO
ALTER DATABASE [BlogEngine] SET  READ_WRITE 
GO
