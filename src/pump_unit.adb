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
   end Lift_Nozzle;

   procedure replaceNozzle (curr_fuel: in fuel_type) is
   begin
      enterWaitingState(curr_pump(curr_fuel));
   end Replace_Nozzle;

   procedure requestPumping (curr_fuel: in fuel_type, f: in price) is
      fuel_left:price := fuel_needed - fuel_pumped;
      fuel_pump_volume:fuel_volume;
      fuel_reserve_volume:fuel_volume:=fuelLeftInReserve(curr_pump(curr_fuel));
      fuel_to_be_pumped:price;
   begin
      if (f> fuel_left) then
         fuel_to_be_pumped=fuel_left;
      else
         fuel_to_be_pumped=f;
      end if;

      fuel_pump_volume:=fuel_to_be_pumped/curr_price(curr_fuel);

      if (fuel_pump_volume>fuel_reserve_volume) then
         fuel_pump_volume:=fuel_reserve_volume;
         --there is only reserve_volume left
      end if;

      if (fuel_pump_volume>0) then
        startPumping(curr_pump(curr_fuel),fuel_pump_volume);
        fuel_pumped := fuel_pumped + fuel_pump_volume*curr_price(curr_fuel);
      else
         --stop pumping and back to ready state
      end if;
   end requestPumping;



end Pump_Unit;
