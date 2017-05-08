with Ada.Text_IO; use Ada.Text_IO;
with Pump_type; use Pump_type;
with Pump_Unit; use Pump_Unit;
with Pump; use Pump;

package body boundary is

   procedure InputFuelVolume(v: price) is
   begin
      Put("Customer set fuel volume: ");
      Put(v'Image);
      New_Line;
   end InputFuelVolume;

   procedure InputNozzleLift(f: fuel_type) is
   begin
      Put("Customer Lifted the nozzle: ");
      Put(f'Image);
      New_Line;
   end InputNozzleLift;

   procedure InputTankSensor(f: Boolean) is
   begin
      if f then
         Put_Line("The Tank is Full");
      else
         Put_Line("The Tank Sensor Reset to False");
      end if;
   end InputTankSensor;

   procedure InputPressNozzle(f: fuel_type) is
   begin
      Put("Customer pressed the nozzle: ");
      Put(f'Image);
      New_Line;
   end InputPressNozzle;

   procedure InputReleaseNozzle( f: fuel_type) is
   begin
      Put("Customer released the nozzle: ");
      Put(f'Image);
      New_Line;
   end InputReleaseNozzle;

   procedure InputReplaceNozzle( f:fuel_type) is
   begin
      Put("Customer replaced the nozzle back to cradle: ");
      Put(f'Image);
      New_Line;
   end InputReplaceNozzle;

   procedure InputPayment(p: price) is
   begin
      Put("Customer pay the cash: ");
      Put(p'Image);
      New_Line;
   end InputPayment;

   procedure OutputStatus is
   begin
      New_Line;
      Put_Line("Pump State Cradle TankFull Reservior UnPaid Cash");
      for i in fuel_type loop
         Put(i'Image&" ");
         Put(getState(curr_pump(i))'Image&" ");
         Put(getCradle(curr_pump(i))'Image&" ");
         Put(getTankSensor(curr_pump(i))'Image&" ");
         Put(getReservior(curr_pump(i))'Image&" ");
         Put(getUnPaid(curr_pump(i))'Image&" ");
         Put(getCash(curr_pump(i))'Image&" ");
         New_Line;
      end loop;
      New_Line;
   end OutputStatus;

end boundary;
