pragma SPARK_Mode (On);
with Pump_type; use Pump_type;
package Pump is

   type nozzle is private;

   function inBaseState (n: in nozzle)
                          return Boolean;

   function inReadyState (n: in nozzle)
                          return Boolean;

   function inPumpingState (n: in nozzle)
                            return Boolean;

   function inWaitingState (n: in nozzle)
                            return Boolean;

   procedure enterReadyState (n: in out nozzle)
     with
       Global => null,
       Depends => (n =>+ null),
       Pre => (inBaseState(n) or inPumpingState(n) or inWaitingState(n)),
       Post => (inReadyState(n));

   procedure startPumping (n: in out nozzle; v: in out fuel_volume)
     with
       Global => null,
       Depends => (n =>+ v, v =>+ n),
       Pre => (inReadyState(n) or inPumpingState(n)),
       Post => (inPumpingState(n) and v<=v'Old)
   ;

   procedure enterWaitingState (n: in out nozzle)
     with
       Global => null,
       Depends => (n=>+ null),
     Pre => (inReadyState(n)),
     Post => (inWaitingState(n));

   procedure enterBaseState (n: in out nozzle)
     with
       Global => null,
       Depends => (n=>+ null),
     Pre => (inWaitingState(n)),
     Post => (inBaseState(n));

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
      R : fuel_volume:=1000.0; --Fuel in Reservior
     end record;


end Pump;
