
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,14-dec-2017>
-- Description:	<Description,To save or update user>
-- =============================================
ALTER PROCEDURE sp_SaveUser
	@userId			bigint=0,
	@firstName		nvarchar(100),
	@lastName		nvarchar(100),
	@userName		nvarchar(100),
	@password		nvarchar(100),
	@role			int=0,
	@userStatus		int=0,
	@gender			nvarchar(20),
	@email			nvarchar(100),
	@country		nvarchar(100),
	@regDate		datetime=null,
	@designation	nvarchar(200)
AS
BEGIN	
	IF(@userId <>0 and @userId is not null)
	BEGIN
		UPDATE Users set FirstName=@firstName,LastName=@lastName,UserName=@userName,Password=@password,Role=@role,UserStatus=@userStatus,
		Gender=@gender,Country=@country,Designation=@designation,Email=@email where UserId=@userId
	END
	ELSE
	BEGIN
		INSERT into Users(FirstName,LastName,UserName,Password,Role,UserStatus,Gender,Country,Designation,RegistrationDate,Email)
		VALUES(@firstName,@lastName,@userName,@password,@role,@userStatus,@gender,@country,@designation,@regDate,@email)
	END
    
END
GO
