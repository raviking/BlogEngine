
USE [BlogEngine]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllCategories]    Script Date: 11/9/2017 7:50:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Raviteja Swayampu>
-- Create date: <Create Date,8-nov-2017>
-- Description:	<Description,Get Current user>
-- =============================================

-- Exec sp_GetCurrentUser '1'

CREATE PROCEDURE [dbo].[sp_GetCurrentUser]
	@userName nvarchar(100)=null,
	@password nvarchar(100)=null
AS
BEGIN
	
	SET NOCOUNT ON;

	select U.UserId,U.FirstName,U.LastName,U.UserName,U.Password,R.RoleName,U.UserStatus,U.Gender,
	U.Country,U.Designation,U.RegistrationDate from Users U inner join Roles R on R.RoleId=U.Role
	where U.UserName=@userName and U.Password=@password
END

