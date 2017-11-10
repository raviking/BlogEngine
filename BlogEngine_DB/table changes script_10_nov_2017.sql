
alter table Post add UserId bigint foreign key references Users(UserId)

update Post set UserId=1



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,10-nov-2017>
-- Description:	<Description,Gets all posts based on UserId>
-- =============================================
CREATE PROCEDURE sp_GetPostsByUserId
	@userId bigint=0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT postid,title,shortdescription,postdescription,postmeta,posturlslug,ispublished,postedon,createdby,
	createddate,poststatus,ModifiedDate,CategoryId,Userid from Post where UserId=@userId
END
GO
