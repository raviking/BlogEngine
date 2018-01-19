

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

	IF(@userId>0)
	
	BEGIN
		select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email,(Select null) as PostCount from Users U inner join Roles R on R.RoleId=U.Role
		where U.UserId=@userId
	END
	ELSE
	BEGIN
		select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName as Role,U.UserStatus,U.Gender,
		U.Country,U.Designation,U.RegistrationDate,U.Email,(Select null)as PostCount from Users U inner join Roles R on R.RoleId=U.Role
		where U.UserName=@userName and U.Password=@password
	END
END