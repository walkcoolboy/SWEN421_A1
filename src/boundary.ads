with Ada.Text_IO; use Ada.Text_IO;
with Pump_type; use Pump_type;
with Pump_Unit; use Pump_Unit;
with Pump; use Pump;

package boundary is
   --boundary I/O package

   procedure InputFuelVolume(v: price);

   procedure InputNozzleLift(f: fuel_type);

   procedure InputTankSensor(f: Boolean);

   procedure InputPressNozzle(f: fuel_type);

   procedure InputReleaseNozzle( f: fuel_type);

   procedure InputReplaceNozzle( f:fuel_type);

   procedure InputPayment(p: price);

   procedure OutputStatus;

end boundary;
