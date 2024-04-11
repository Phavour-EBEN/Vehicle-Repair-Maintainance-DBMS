CREATE TRIGGER PreventVehicleDeleteWithOpenRepair
ON Vehicles
FOR DELETE
AS
BEGIN
  DECLARE @has_open_repairs INT;

  SELECT @has_open_repairs = COUNT(*)
  FROM Repairs R
  LEFT JOIN Payments P ON R.repair_id = P.repair_id
  WHERE R.vehicle_id IN (SELECT vehicle_id FROM DELETED) AND P.payment_id IS NULL;

  IF @has_open_repairs > 0
  BEGIN
    RAISERROR('Cannot delete vehicle with open repairs.', 16, 1);
    ROLLBACK TRANSACTION;  -- Prevent deletion if open repairs exist
  END;
  ELSE
  BEGIN
    -- If there are no open repairs, allow deletion
    DELETE FROM Repairs WHERE vehicle_id IN (SELECT vehicle_id FROM DELETED);
    -- Optionally, you might want to delete associated payments as well
    DELETE FROM Payments WHERE repair_id IN (SELECT repair_id FROM Repairs WHERE vehicle_id IN (SELECT vehicle_id FROM DELETED));
  END;
END;
