pragma SPARK_Mode (On);
package Pump is



   type nozzle is private;

   procedure enterReadyState (n: in out nozzle)
     with
       Global => null,
       Depends => (n =>+ null)
       Pre => (((n.S=Base) or (n.S=Waiting))
             and n.C=True);

   function fuelLeftInReserve (n: in nozzle)
     return fuel_volume;

   procedure startPumping (n: in out nozzle, v: in fuel_volume)
     with
       Global => null,
       Depends => (n =>+ null)
     --Pre => ()
   ;

   procedure enterWaitingState (n: in out nozzle)
     with
       Global => null,
       Depends => (n=>+ null);

   procedure enterBaseState (n: in out nozzle)
     with
       Global => null,
       Depends => (n=>+ null);

   procedure tankSensorOn (n: in out nozzle)
     with
       Global => null,
       Depends => (n=>+ null);

   procedure tankSensorOff (n: in out nozzle)
     with
       Global => null,
       Depends => (n=>+ null);

   private

     type state is (Base, Ready, Pumping, Waiting);
     type nozzle_in_cradle is new Boolean;
     type full_tank_sensor is new Boolean;

     type nozzle is record
      S : state:=Base;
      C : nozzle_in_cradle:=True;
      F : full_tank_sensor:=False;
      PF: fuel_volume:=0.0; --Pumped Fuel
      R : fuel_volume:=1000.0; --Fuel in Reservior
     end record;


end Pump;
