USE [FleetManagement]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Employee]    Script Date: 24-03-2016 07:58:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Insert_Employee]
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Designation VARCHAR(20),
	@Salary MONEY,
	@DateOfJoin DATETIME,
	@Qualification VARCHAR(50),
	@DateOfBirth DATETIME,
	@Address VARCHAR(100),
	@Country VARCHAR(50),
	@State VARCHAR(50),
	@Phone VARCHAR(20),
	@EmailID VARCHAR(50)

AS
	BEGIN
		
		INSERT INTO Employee
		(FirstName, 
		LastName, 
		Designation, 
		Salary, 
		DateOfJoin, 
		Qualification, 
		DateOfBirth, 
		[Address], 
		Country, 
		[State], 
		Phone, 
		EmailID)

		VALUES(
		@FirstName,
		@LastName,
		@Designation,
		@Salary,
		@DateOfJoin,
		@Qualification,
		@DateOfBirth,
		@Address,
		@Country,
		@State,
		@Phone,
		@EmailID
		)

	END
	
