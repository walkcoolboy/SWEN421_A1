pragma SPARK_Mode (On);
with Pump; use Pump;
with Pump_type; use Pump_type;

package Pump_Unit is

   type Three_pumps is array (fuel_type) of nozzle;


   subtype fuel_price is price range 0.0..5.0;
   type fuel_unit_price is array (fuel_type) of fuel_price;

   curr_pump: Three_pumps;
   fuel_needed: fuel_price:=0.0;
   cashInRegister: fuel_price:=0.0;

   procedure setFuelVolume (f: in price)
     with
       Global => (In_Out => fuel_needed),
     Depends => (fuel_needed =>+ f);

   --response to customer action to lift nozzle of particular fuel type
   procedure liftNozzle (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump), --to change the state of current pump
       Depends => (curr_pump =>+ curr_fuel)
       --Pre => --nozzle in the cradle (Pump is Base or Waiting)
       --Post => --nozzle is lifted and Pump enter the Ready state
   ;

   procedure replaceNozzle (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
       --Pre =>
       --Post=>
   ;

   procedure pressAndReleaseNozzle (curr_fuel: in fuel_type, f: in price)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
   ;

   --full tank sensor, taking a input of fuel_price when tank reaching full
   procedure tankFull (curr_fuel: in fuel_type, f: in price)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
   ;

   procedure tankFullReset (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
   ;

   procedure setPayment (curr_fuel: in fuel_type, payment: in price)
      with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
   ;

end Pump_Unit;
