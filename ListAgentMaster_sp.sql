USE [E-Transport_Machine]
GO
/****** Object:  StoredProcedure [dbo].[ListAgentMaster_sp]    Script Date: 20/04/2021 4:48:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ListAgentMaster_sp]
	@AgentName Nvarchar(100),
	@AgentPanNo Nvarchar(50),
	@PageIndex INT, 
	@PageSize INT,
	@IsExportToExcel INT
	--@TotalRows INT OUT
AS

IF @IsExportToExcel = 0
Begin
	SELECT 
		--ROW_NUMBER() OVER(ORDER BY [Age_Id] DESC) as RowNumber,
		Count(*)over() as TotalRows,
		Age_Id, 
		Age_Name, 
		Age_EmailId, 
		Age_Address, 
		Age_City, 
		Age_State, 
		Age_Country, 
		Age_Phone, 
		Age_Mobile, 
		Age_TinNo, 
		Age_PanNo, 
		Age_Status, 
		Age_Commission, 
		Age_Value, 
		Age_CreatedBy, 
		Age_CrearedDate, 
		Age_UpdatedBy, 
		Age_UpdatedDate,
		Age_RateType,
		Age_RateOn
		--Into #tempAgentMaster  
	FROM 
		AGENTMASTER_TBL
	Where
		(CASE WHEN (@AgentName = '') THEN '1' ELSE CONVERT(NVARCHAR(50), Age_Name) END) LIKE (CASE WHEN (@AgentName = '') THEN '1' ELSE CONVERT(NVARCHAR(50), '%'+@AgentName+'%') END) 
	ANd
		(Case When @AgentPanNo='' Then '1' else Convert(nvarchar(50),Age_PanNo) End)  Like  (Case When @AgentPanNo='' Then '1' else Convert(nvarchar(50),'%'+@AgentPanNo+'%' )END)
	Order by Age_Id Desc
	OFFSET (@PageIndex - 1) * @PageSize Rows
	FETCH Next @PageSize Rows Only
	--SET @TotalRows =  (SELECT  COUNT(RowNumber) FROM  #tempAgentMaster)
	--	SELECT 
	--		* 
	--	FROM 
	--		#tempAgentMaster
	--	WHERE 
	--		RowNumber between (@PageIndex-1) * @PageSize + 1 
	--	AND 
	--		(((@PageIndex - 1) * @PageSize + 1) + @PageSize) - 1 
	--	DROP TAble #tempAgentMaster	
End
Else
Begin
	SELECT 
		Count(*)over() as TotalRows,
		Age_Id, 
		Age_Name, 
		Age_EmailId, 
		Age_Address, 
		Age_City, 
		Age_State, 
		Age_Country, 
		Age_Phone, 
		Age_Mobile, 
		Age_TinNo, 
		Age_PanNo, 
		Age_Status, 
		Age_Commission, 
		Age_Value, 
		Age_CreatedBy, 
		Age_CrearedDate, 
		Age_UpdatedBy, 
		Age_UpdatedDate,
		Age_RateType,
		Age_RateOn  
	FROM 
		AGENTMASTER_TBL
End

RETURN