pragma SPARK_Mode (On);
with Pump; use Pump;
with Pump_type; use Pump_type;

package Pump_Unit is

   type Three_pumps is array (fuel_type) of nozzle;


   subtype fuel_price is price range 0.0..5.0;
   type fuel_unit_price is array (fuel_type) of fuel_price;
   curr_price:fuel_unit_price;

   curr_pump: Three_pumps;
   fuel_needed: fuel_price:=0.0;
   fuel_pumped: fuel_price:=0.0;
   cashInRegister: fuel_price:=0.0;

   procedure setFuelVolume (f: in price)
     with
       Global => (In_Out => fuel_needed),
     Depends => (fuel_needed =>+ f);

   procedure setFuelPrice (P91, P95, PD: in fuel_price)
     with
       Global => (Out => curr_price),
       Depends => (curr_price => (P91, P95, PD));


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

   procedure requestPumping (curr_fuel: in fuel_type, f: in price)
     with
       Global => (Input => fuel_needed,
                    In_Out => (curr_pump,fuel_pumped)),
       Depends => (curr_pump =>+ (curr_fuel,f))
       Pre =>
   ;

   procedure requestStopPumping (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel)
       --Pre =>
       --Post=>
   ;

   -- full tank sensor signal
   procedure TankSensorInput (curr_fuel: in fuel_type, signal: in Boolean)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ (curr_fuel, signal))
   ;

   --customer must pay full amount of fuel pumped
   procedure setPayment (curr_fuel: in fuel_type, payment: in price)
      with
       Global => (In_Out => (curr_pump, cashInRegister)),
       Depends => (curr_pump =>+ curr_fuel,
                  cashInRegister =>+ payment)
   ;

end Pump_Unit;
