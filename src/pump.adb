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

   procedure startPumping (n: in out nozzle; v:in out fuel_volume) is
   begin
      n.S:=Pumping;
      if (n.F) then
         --the tank is full
         v:=0.0;
      else
         if (v>n.R) then
            --reservior fuel less than requested
            v:=n.R;
         else
            --call pumping driver
            n.R:=n.R-v;
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

end Pump;
