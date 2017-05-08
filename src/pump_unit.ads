pragma SPARK_Mode (On);
With Pump; use Pump;
with Pump_type; use Pump_type;

package Pump_Unit is

   type Three_pumps is array (fuel_type) of nozzle;

   curr_pump: Three_pumps;
   fuel_needed: price:=0;
   fuel_pumped: price:=0;

   procedure setFuelVolume (f: in price)
     with
       Global => (Output => fuel_needed),
       Depends => (fuel_needed => f),
       pre => (f <=200);


   --response to customer action to lift nozzle of particular fuel type
   procedure liftNozzle (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump), --to change the state of current pump
       Depends => (curr_pump =>+ curr_fuel),
       --nozzle in the cradle (Pump is Base or Waiting)
     Pre => ((inBaseState(curr_pump(curr_fuel)) or inWaitingState(curr_pump(curr_fuel))) and
                 --other two nozzles must be in Base State
             (for all f in fuel_type => (f /= curr_fuel and then inBaseState(curr_pump(f))))),
     --nozzle is lifted and Pump enter the Ready state
     Post =>  inReadyState(curr_pump(curr_fuel))
   ;

   procedure replaceNozzle (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel),
       --nozzle not in the cradle (Ready state), and can only switch to waiting state
       Pre =>  inReadyState(curr_pump(curr_fuel)),
       Post=> inWaitingState(curr_pump(curr_fuel))
   ;

   procedure requestPumping (curr_fuel: in fuel_type; f: in price)
     with
       Global => (Input => (fuel_needed),
                    In_Out => (curr_pump,fuel_pumped)),
       Depends => (curr_pump =>+ (curr_fuel,fuel_needed,f, fuel_pumped),
                   fuel_pumped =>+ (fuel_needed,f, curr_fuel, curr_pump)),
       Pre => (inReadyState(curr_pump(curr_fuel)) or inPumpingState(curr_pump(curr_fuel))) and
                 f<=100 and fuel_pumped<=200 and
               (fuel_needed=0 or fuel_needed>fuel_pumped),
     Post => (inPumpingState(curr_pump(curr_fuel)) or inReadyState(curr_pump(curr_fuel)))
   ;

   procedure requestStopPumping (curr_fuel: in fuel_type)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ curr_fuel),
       Pre => inPumpingState(curr_pump(curr_fuel)),
       Post=> inReadyState(curr_pump(curr_fuel))
   ;

   -- full tank sensor signal
   procedure TankSensorInput (curr_fuel: in fuel_type; signal: in Boolean)
     with
       Global => (In_Out => curr_pump),
       Depends => (curr_pump =>+ (curr_fuel, signal)),
       Pre => (inPumpingState(curr_pump(curr_fuel)) or inReadyState(curr_pump(curr_fuel)))
   ;

   --customer must pay full amount of fuel pumped
   procedure setPayment (curr_fuel: in fuel_type; payment: in price)
      with
       Global => (In_Out => (curr_pump, fuel_pumped),
                  Output => fuel_needed),
       Depends => (curr_pump =>+ (curr_fuel, payment),
                   (fuel_pumped, fuel_needed) => null,
                   null => fuel_pumped),
     Pre => inWaitingState(curr_pump(curr_fuel))
            and balanceCheck(curr_pump(curr_fuel),payment),
       Post => inBaseState(curr_pump(curr_fuel)) and
                 fuel_pumped =0 and fuel_needed=0
   ;

end Pump_Unit;
