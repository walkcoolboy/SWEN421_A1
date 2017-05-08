pragma SPARK_Mode (On);
package body Pump is

   function inBaseState (n: in nozzle) return Boolean is
      (n.S=Base and n.C=True);

   function inReadyState(n:in nozzle) return Boolean is
      (n.S=Ready and n.C=False);

   function inPumpingState (n: in nozzle) return Boolean is
      (n.S=Pumping and n.C=False);

   function inWaitingState (n: in nozzle) return Boolean is
     (n.S=Waiting and n.C=True);

   procedure enterReadyState (n: in out nozzle) is
   begin
      n.C:=False;
      n.S:=Ready;
   end enterReadyState;

   function inRange(n: in nozzle; v:in price) return Boolean is
     (n.p<=1000 and v<=1000);

   procedure startPumping (n: in out nozzle; v:in out price) is
   begin
      n.S:=Pumping;
      if (n.F) then
         --the tank is full
         v:=0;
      else
         if (v>n.R) then
            --reservior fuel less than requested
            v:=n.R;
            n.R:=0;
            n.P:=n.P+v;
         else
            --call pumping driver
            n.R:=n.R-v;
            n.P:=n.P+v;
         end if;
      end if;
   end startPumping;

   procedure enterWaitingState (n: in out nozzle) is
   begin
      n.C:=True;
      n.S:=Waiting;
   end enterWaitingState;

   procedure enterBaseState (n: in out nozzle) is
   begin
      n.S:=Base;
   end enterBaseState;

   procedure registerTankSensor (n: in out nozzle; s: in Boolean) is
   begin
      if s then
         n.F:=True;
      else
         n.F:=False;
      end if;
   end registerTankSensor;

   function balanceCheck(n: in nozzle; payment: in price) return Boolean is
     (payment=n.P and n.Cash<=1000 and payment<=1000);

   function noUnPaid (n: in nozzle) return Boolean is
      (n.P=0);

   procedure setBalance (n: in out nozzle; payment: in price) is
   begin
      n.P:=n.P-payment;
      n.Cash := n.Cash +payment;
   end setBalance;

   function getState(n: in nozzle) return State is
   begin
      return n.S;
   end getState;

   function getCradle(n: in nozzle) return nozzle_in_cradle is
   begin
      return n.C;
   end getCradle;

   function getTankSensor(n: in nozzle) return full_tank_sensor is
   begin
      return n.F;
   end getTankSensor;

   function getReservior(n: in nozzle) return price is
   begin
      return n.R;
   end getReservior;

   function getUnPaid(n: in nozzle) return price is
   begin
      return n.P;
   end getUnPaid;

   function getCash(n: in nozzle) return price is
   begin
      return n.Cash;
   end getCash;

end Pump;
