with Pump_Unit; use Pump_Unit;
with Pump_type; use Pump_type;
with boundary; use boundary;

procedure Main is

begin

   --simulate scenario 1
   InputFuelVolume(40); setFuelVolume(40);OutputStatus;
   InputNozzleLift(Petrol91); liftNozzle(Petrol91); OutputStatus;
   InputPressNozzle(Petrol91); requestPumping(Petrol91, 10); OutputStatus;
   InputReleaseNozzle(Petrol91); requestStopPumping(Petrol91); OutputStatus;
   InputReplaceNozzle(Petrol91); replaceNozzle(Petrol91); OutputStatus;
   InputPayment(10); setPayment(Petrol91, 10); OutputStatus;

   --simulate scenario 2
   --customer want to fuel up, so did not set fuel volume
   InputNozzleLift(Petrol95); liftNozzle(Petrol95); OutputStatus;
   InputPressNozzle(Petrol95); requestPumping(Petrol95, 40); OutputStatus;
   InputTankSensor(True); TankSensorInput(Petrol95, True); OutputStatus;
   InputPressNozzle(Petrol95); requestPumping(Petrol95, 1); OutputStatus;
   InputTankSensor(False); TankSensorInput(Petrol95, False); OutputStatus;
   InputReplaceNozzle(Petrol95); replaceNozzle(Petrol95); OutputStatus;
   InputPayment(40); setPayment(Petrol95, 40); OutputStatus;

   --simulate scenario 3
   InputFuelVolume(60); setFuelVolume(60);OutputStatus;
   InputNozzleLift(Petrol95); liftNozzle(Petrol95); OutputStatus;
   InputPressNozzle(Petrol95); requestPumping(Petrol95, 50); OutputStatus;
   InputPressNozzle(Petrol95); requestPumping(Petrol95, 10); OutputStatus;
   InputPressNozzle(Petrol95); requestPumping(Petrol95, 1); OutputStatus;
   InputReplaceNozzle(Petrol95); replaceNozzle(Petrol95); OutputStatus;
   InputPayment(60); setPayment(Petrol95, 60); OutputStatus;


end Main;
