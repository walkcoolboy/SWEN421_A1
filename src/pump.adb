pragma SPARK_Mode (On);
package body Pump is

   procedure enterReadyState (n: in out nozzle) is
   begin
      n.C:=False;
      n.S:=Ready;
   end enterReadyState;

   procedure enterPumpingState (n: in out nozzle, v:in fuel_volume) is
   begin

      n.S:=Pumping;
   end enterPumpingState;

end Pump;
