with Pump_Unit; use Pump_Unit;

procedure Main is

begin

   --simulate scenario 1
   setFuelVolume(40.0(fuel_price));
   liftNozzle(Petrol91);
   requestPumping(Petrol91, 10.0);

   --simulate scenario 2
   setFuelVolume(0.0(fuel_price));
   liftNozzle(Petrol95);
   requestPumping(Petrol95, 10.0);
   setTankFull(Petrol95);

end Main;
