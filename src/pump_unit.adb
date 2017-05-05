pragma SPARK_Mode (On);
with Pump_type; use Pump_type;
with Pump; use Pump;

package body Pump_unit is

   procedure setFuelVolume (f: in price) is
   begin
      fuel_needed := f;
   end setFuelVolume;

   procedure setFuelPrice (P91, P95, PD: in fuel_price) is
   begin
      curr_price(Petrol91):=P91;
      curr_price(Petrol95):=P95;
      curr_price(Diesel):=PD;
   end setFuelPrice;

   procedure liftNozzle (curr_fuel: in fuel_type) is
   begin
      enterReadyState(curr_pump(curr_fuel));
   end liftNozzle;

   procedure replaceNozzle (curr_fuel: in fuel_type) is
   begin
      enterWaitingState(curr_pump(curr_fuel));
   end replaceNozzle;

   procedure requestPumping (curr_fuel: in fuel_type; f: in price) is
      fuel_pump_volume:fuel_volume;
      fuel_to_be_pumped:price;
   begin

      if ((fuel_needed/=0.0) and (f>(fuel_needed-fuel_pumped))) then
         fuel_to_be_pumped:=fuel_needed-fuel_pumped;
      else
         fuel_to_be_pumped:=f;
      end if;

      fuel_pump_volume:=fuel_volume(Float(fuel_to_be_pumped)/Float(curr_price(curr_fuel)));

      startPumping(curr_pump(curr_fuel),fuel_pump_volume);

      if (fuel_pump_volume>0.0) then
        fuel_pumped := fuel_pumped + price(Float(fuel_pump_volume)*Float(curr_price(curr_fuel)));
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
      cashInRegister := cashInRegister + payment;
      fuel_pumped:=0.0;
      fuel_needed:=0.0;
      enterBaseState(curr_pump(curr_fuel));
   end setPayment;

end Pump_Unit;
