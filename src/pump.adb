pragma SPARK_Mode (On);
package body Pump is

   procedure setCradle (n: in out nozzle) is
   begin
      n.C:=False;
   end setCradle;

end Pump;
