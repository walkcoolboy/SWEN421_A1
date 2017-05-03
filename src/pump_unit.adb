pragma SPARK_Mode (On);
with Pump_type; use Pump_type;
with Pump; use Pump;

package body Pump_unit is

   procedure setFuelVolume (f: in price) is
   begin
      fuel_needed := f;
   end setFuelVolume;

   procedure liftNozzle (curr_fuel: in fuel_type) is
   begin
      enterReadyState(curr_pump(curr_fuel));
   end Lift_Nozzle;

   procedure replaceNozzle (curr_fuel: in fuel_type) is
   begin
      enterWaitingState(curr_pump(curr_fuel));
   end Replace_Nozzle;

   procedure requestPumping (curr_fuel: in fuel_type, f: in price) is
   begin
      if (f <=

end Pump_Unit;
