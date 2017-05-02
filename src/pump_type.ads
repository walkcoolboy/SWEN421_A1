pragma SPARK_Mode (On);
package Pump_type is

   type fuel_type is (Petrol91, Petrol95, Diesel);
   type fuel_volume is new Float range 0.0..Float'Last;
   type price is new Float range 0.0..Float'Last;

end Pump_type;
