// ---------------------------------------------------------------------------
// Example NewPing library sketch that does a ping about 20 times per second.
// ---------------------------------------------------------------------------

#include <NewPing.h>
// Sensor pins
#define sensorPower 7
#define sensorPin A0

#define TRIGGER_PIN  8  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     12  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 600 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
// Value for storing water level
int val = 0;
int dist = 0;

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup() {
  Serial.begin(9600); // Open serial monitor at 115200 baud to see ping results.
}

void loop() {
   digitalWrite(sensorPower, HIGH);
  delay(10);
  
  val = analogRead(sensorPin);
   Serial.println(val);
   digitalWrite(sensorPower, LOW);
   if(val==0) Serial.println("dry....");
dist=(sonar.ping_cm());
   if(dist <400){
  delay(500);                     // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  Serial.print("Ping: ");
  Serial.print(sonar.ping_cm()); // Send ping, get distance in cm and print result (0 = outside set distance range)
  Serial.println("cm");
   }else{
   dist=400;
   Serial.print("distance to big...: ");
   Serial.print(dist);
   Serial.println("cm");
   } 
}
