pragma SPARK_Mode (On);
package Pump_type is

   type fuel_type is (Petrol91, Petrol95, Diesel);
   type price is new Integer range 0..3000;
   type state is (Base, Ready, Pumping, Waiting);
   type nozzle_in_cradle is new Boolean;
   type full_tank_sensor is new Boolean;

end Pump_type;
