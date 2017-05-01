pragma SPARK_Mode (Off);
package Device_Driver is

   procedure Lift_Nozzle (thepump: in out Pump)
     with Pre => --nozzle in the cradle (Pump is Base or Waiting)
       Post => --nozzle is lifted and Pump enter the Ready state
   ;

   procedure Replace_Nozzle (thepump: in out Pump)
     with Pre =>
       Post=>
   ;

end Device_Driver;
