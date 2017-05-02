pragma SPARK_Mode (On);
with Pump; use Pump;
with Pump_type; use Pump_type;

package Pump_Unit is

   type Three_pumps is array (fuel_type) of nozzle;
   type Three_reservoir is array (fuel_type) of fuel_volume;

   subtype fuel_price is price range 0.0..5.0;
   type fuel_unit_price is array (fuel_type) of fuel_price;

   curr_pump: Three_pumps;

   procedure Lift_Nozzle (curr_fuel: in fuel_type) --response to customer action to lift nozzle of particular fuel type
     with
       Global => (In_Out => curr_pump), --to change the state of current pump
       Depends => (curr_pump =>+ curr_fuel)
       --Pre => --nozzle in the cradle (Pump is Base or Waiting)
       --Post => --nozzle is lifted and Pump enter the Ready state
   ;

   procedure Replace_Nozzle (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
       --Pre =>
       --Post=>
   ;




end Pump_Unit;
