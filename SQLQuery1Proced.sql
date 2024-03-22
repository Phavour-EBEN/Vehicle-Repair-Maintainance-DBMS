CREATE PROCEDURE CalculateTotalRepairCost (@repair_id INT)
AS
BEGIN
  DECLARE @total_cost DECIMAL(10,2);

  -- Calculate labor cost by looking up service details in Services table
  SELECT @total_cost = SUM(labor_cost)
  FROM Repairs R
  INNER JOIN Services S ON R.service_id = S.service_id
  WHERE R.repair_id = @repair_id;

  -- Return the total cost
  SELECT @total_cost;
END;