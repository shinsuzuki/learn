CREATE FUNCTION [dbo].[ufn_upper ]
(
	@TargetStr varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
  declare @resultStr varchar(50);

  set @resultStr = (select upper(@TargetStr))

  RETURN @resultStr;
END
GO

