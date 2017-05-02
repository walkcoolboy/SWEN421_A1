pragma SPARK_Mode (On);
with Pump_type; use Pump_type;
with Pump; use Pump;

package body Pump_unit is

   procedure Lift_Nozzle (curr_fuel: in fuel_type) is
   begin
      setCradle(curr_pump(curr_fuel));
   end Lift_Nozzle;

   procedure Replace_Nozzle (curr_fuel: in fuel_type) is
   begin
      setCradle(curr_pump(curr_fuel));
   end Replace_Nozzle;

end Pump_Unit;
