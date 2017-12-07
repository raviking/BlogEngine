SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Raviteja Swayampu>
-- Create date: <Create Date,7_dec_2017>
-- Description:	<Description,To fill country dropdowns>
-- =============================================
CREATE PROCEDURE sp_GetAllCountries
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT ID,CountryName FROM Country
END
GO
