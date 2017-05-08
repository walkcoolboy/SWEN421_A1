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

   function inRange(n: in nozzle; v:in price) return Boolean;

   procedure startPumping (n: in out nozzle; v: in out price)
     with
       Global => null,
       Depends => (n =>+ v, v =>+ n),
     Pre => (inReadyState(n) or inPumpingState(n)) and
             inRange(n,v),
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
     Pre => inWaitingState(n) and noUnPaid(n),
     Post => (inBaseState(n));

   procedure registerTankSensor (n: in out nozzle; s: in Boolean)
     with
       Global => null,
       Depends => (n=>+ s);

   function balanceCheck(n: in nozzle; payment: in price) return Boolean;

   function noUnPaid (n: in nozzle) return Boolean;

   procedure setBalance (n: in out nozzle; payment: in price)
     with
       Global => null,
       Depends => (n=>+ payment),
     Pre => balanceCheck(n, payment) and
             inWaitingState(n),
     Post => inWaitingState(n) and noUnPaid(n);

   function getState(n: in nozzle) return State;

   function getCradle(n: in nozzle) return nozzle_in_cradle;

   function getTankSensor(n: in nozzle) return full_tank_sensor;

   function getReservior(n: in nozzle) return price;

   function getUnPaid(n: in nozzle) return price;

   function getCash(n: in nozzle) return price;

   private

     type nozzle is record
      S : state:=Base;
      C : nozzle_in_cradle:=True;
      F : full_tank_sensor:=False;
      R : price:=1000; --Fuel in Reservior
      P : price:=0; --total fuel yet to be paid for
      Cash : price:=0; --total cash received
     end record
        with Type_Invariant => balance(nozzle);

   function balance (n: in nozzle) return Boolean
   is
      (n.P<=1000 and n.Cash<=1000 and n.R<=1000 and (Integer(n.R)+Integer(n.P)+Integer(n.Cash)= 1000));

end Pump;
