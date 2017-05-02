pragma SPARK_Mode (On);
package Pump is



   type nozzle is private;

   procedure setCradle (n: in out nozzle)
     with
       Global => null;

   private

     type state is (Base, Ready, Pumping, Waiting);
     type nozzle_in_cradle is new Boolean;
     type full_tank_sensor is new Boolean;

     type nozzle is record
      S : state:=Base;
      C : nozzle_in_cradle:=True;
      F : full_tank_sensor:=False;
     end record;


end Pump;
