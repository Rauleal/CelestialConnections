// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
#include "DHT.h"
#include <NewPing.h>

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 500 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

int maxDist = 500;
int distance = 0;

#define DHTPIN 2     // Digital pin connected to the DHT sensor
#define DHTTYPE DHT11   // DHT 11
DHT dht(DHTPIN, DHTTYPE);
float h = 0; // humidity
float t = 0; // Read temperature as Celsius (the default)
float hic = dht.computeHeatIndex(t, h, false); // Compute heat index in Celsius (isFahreheit = false)

void setup() {
  Serial.begin(9600); // Open serial monitor at 115200 baud to see ping results.
  dht.begin();
}

void loop() {
  delay(2000); // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  distance = readDistance(maxDist);
  readDht11();
  
  Serial.print("Ping: ");
  Serial.print(distance); // Send ping, get distance in cm and print result (0 = outside set distance range)
  Serial.println("cm");


  Serial.print(F("Humidity: "));
  Serial.print(h);
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(hic);
  Serial.println(F("°C "));
  
  delay(1000);
}

int readDistance(int maxDistance) {
  if (sonar.ping_cm() < maxDist && sonar.ping_cm() > 0) {
    return sonar.ping_cm();
  } else return maxDistance;
}

void readDht11() {
  h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  t = dht.readTemperature();
  
  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    //return;
  }

  // Compute heat index in Celsius (isFahreheit = false)
  hic = dht.computeHeatIndex(t, h, false);


}
