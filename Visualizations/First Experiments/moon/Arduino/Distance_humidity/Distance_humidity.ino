// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
#include "DHT.h"
#include <NewPing.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 20, 4); // set the LCD address to 0x27 for a 16 chars and 2 line display
//SDA goes to A4 analog pin
//SCL goes to A5 analog pin


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
float hic = 0; // Compute heat index in Celsius (isFahreheit = false)

void setup() {
  Serial.begin(9600); // Open serial monitor at 115200 baud to see ping results.
  dht.begin();
  lcd.init();
}

void loop() {
  delay(2500); // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  
  distance = readDistance(maxDist);
  readDht11();

  Serial.print(distance); // distance
  Serial.print(",");
  Serial.print(h); //humidity
  Serial.print(",");
  Serial.print(t); //temparature in celcious
  Serial.print(",");
  Serial.println(hic); //heat index in celcious

  lcdDisplay();

  //delay(1000);
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

void lcdDisplay() {
  lcd.clear();
  lcd.backlight();
  lcd.setCursor(0,0);//sets cursor at the begining of first line
  lcd.print("Dst:");
  lcd.print(distance);
  lcd.print(" Hm:");
  lcd.print(h);
  lcd.setCursor(0,1); //set cursor at the begining of second line
  lcd.print("T:");
  lcd.print(t);
  lcd.print(" Hi:");
  lcd.print(hic);

}
