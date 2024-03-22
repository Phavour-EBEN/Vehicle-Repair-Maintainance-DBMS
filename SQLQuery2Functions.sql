CREATE FUNCTION dbo.IsValidPhoneFormat (@phone_number VARCHAR(20))
RETURNS INT
AS
BEGIN
  DECLARE @phone_regex VARCHAR(255);
  SET @phone_regex = '^[0-9-+()]{10,20}$';  -- Sample phone number format regex

  -- Returnng 1 if the format matches, 0 otherwise
  RETURN CASE WHEN @phone_number LIKE @phone_regex THEN 1 ELSE 0 END;
END;

-- Executing the function
-- Declare a variable to store the result of the function
DECLARE @result INT;

-- Execute the function with a sample phone number
SET @result = dbo.IsValidPhoneFormat('+1234567890');

-- Print the result
SELECT @result AS IsValidPhoneFormatResult;
