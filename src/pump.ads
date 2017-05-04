pragma SPARK_Mode (On);
with Pump_type; use Pump_type;
package Pump is

   type nozzle is private;

   procedure enterReadyState (n: in out nozzle)
     with
       Global => null,
       Depends => (n =>+ null),
     Pre => (((n.S=Base or n.S=Waiting) and n.C=True)
             or (n.S=Pumping and n.C=False));

   procedure startPumping (n: in out nozzle; v: in out fuel_volume)
     with
       Global => null,
       Depends => (n =>+ v, v =>+ n)
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

   procedure registerTankSensor (n: in out nozzle; s: in Boolean)
     with
       Global => null,
       Depends => (n=>+ s);

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
