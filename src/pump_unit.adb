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
   end liftNozzle;

   procedure replaceNozzle (curr_fuel: in fuel_type) is
   begin
      enterWaitingState(curr_pump(curr_fuel));
   end replaceNozzle;

   procedure requestPumping (curr_fuel: in fuel_type; f: in price)
   is
      fuel_to_be_pumped:price:=f;
   begin

      if ((fuel_needed/=0) and (fuel_to_be_pumped>(fuel_needed-fuel_pumped))) then
         fuel_to_be_pumped:=fuel_needed-fuel_pumped;
      end if;

      pragma Assume (inRange(curr_pump(curr_fuel), fuel_to_be_pumped));
      startPumping(curr_pump(curr_fuel), fuel_to_be_pumped);

      if (fuel_to_be_pumped>0) then
        fuel_pumped := fuel_pumped + fuel_to_be_pumped;
      else
         --stop pumping and back to ready state
         enterReadyState(curr_pump(curr_fuel));
      end if;

   end requestPumping;

   procedure requestStopPumping (curr_fuel: in fuel_type) is
   begin
      enterReadyState(curr_pump(curr_fuel));
   end requestStopPumping;

   procedure TankSensorInput (curr_fuel: in fuel_type; signal: in Boolean) is
   begin
      registerTankSensor(curr_pump(curr_fuel), signal);
   end TankSensorInput;

   procedure setPayment (curr_fuel: in fuel_type; payment: in price) is
   begin
      setBalance(curr_pump(curr_fuel), payment);
      fuel_pumped:=0;
      fuel_needed:=0;
      enterBaseState(curr_pump(curr_fuel));
   end setPayment;

end Pump_Unit;
