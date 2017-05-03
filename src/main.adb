with Pump_Unit; use Pump_Unit;

procedure Main is

begin

   --simulate scenario 1
   setFuelVolume(40.0(fuel_price));
   liftNozzle(Petrol91);
   pressAndReleaseNozzle(Petrol91, 0.0);

   --simulate scenario 2
   setFuelVolume(0.0(fuel_price));
   liftNozzle(Petrol95);
   pressAndReleaseNozzle(Petrol95, 0.0);
   tankFull(Petrol95, 65.0);

end Main;
