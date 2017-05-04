pragma SPARK_Mode (On);
package body Pump is

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
         end if;
         --call pumping driver
         n.PF:= n.PF+v;
         n.R:=n.R-v;
      end if;
   end startPumping;

   procedure enterWaitingState (n: in out nozzle) is
   begin
      n.C:=True;
      n.S:=Waiting;
   end enterWaitingState;

   procedure enterBaseState (n: in out nozzle) is
   begin
      n.S:=Ready;
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
