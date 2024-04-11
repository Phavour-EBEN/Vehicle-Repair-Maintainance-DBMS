Alter PROCEDURE User_Authentication (@username varchar(100),@password varchar(100),@role varchar(100),  @OUTPUT  NVARCHAR(50) OUT )
AS
BEGIN
	Declare @count int;
  SELECT @count=CAST (count(*) AS INT) from Users
  where username = @username and password = @password and role=@role

  if @count = 1 SET @OUTPUT ='User Autheticated'
  else SET @count='User Not Autheticated'

 select @OUTPUT;
  
END;


exec User_Authentication @username='administrator',@password='12345@gh',@role='admin',@OUTPUT='';
