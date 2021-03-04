#define USE_ARDUINO_INTERRUPTS true
#include <PulseSensorPlayground.h>

//  Variables sensor_0 vellnman sensor

int PulseSensor_0 = 0;        // Pulse Sensor PURPLE WIRE connected to ANALOG PIN 0
int LED_0 = 13;   //  The on-board Arduion LED
int Signal_0;  // holds the incoming raw data. Signal value can range from 0-1024
int BPM_0;
int Threshold_0 = 500;            // Determine which Signal to "count as a beat", and which to ingore. usually 550

PulseSensorPlayground pulseSensor_0;

//  Variables sensor_1 giftshop sensor

int PulseSensor_1 = 1;        // Pulse Sensor PURPLE WIRE connected to ANALOG PIN 1
int LED_1 = 7;   //  The on-board Arduion LED
int Signal_1;                // holds the incoming raw data. Signal value can range from 0-1024
int BPM_1;
int Threshold_1 = 900;            // Determine which Signal to "count as a beat", and which to ingore. usually 550

PulseSensorPlayground pulseSensor_1;

void setup() {
  // pinMode(LED_0, OUTPUT);        // pin that will blink to your heartbeat!
  // pinMode(LED_1, OUTPUT);        // pin that will blink to your heartbeat!

  Serial.begin(9600);         // Set's up Serial Communication at certain speed.


  pulseSensor_0.analogInput(PulseSensor_0);
  pulseSensor_0.blinkOnPulse(LED_0);       //auto-magically blink Arduino's LED with heartbeat.
  pulseSensor_0.setThreshold(Threshold_0);
  pulseSensor_0.begin();

  pulseSensor_1.analogInput(PulseSensor_1);
  pulseSensor_1.blinkOnPulse(LED_1);       //auto-magically blink Arduino's LED with heartbeat.
  pulseSensor_1.setThreshold(Threshold_1);
  pulseSensor_1.begin();


}

void loop() {
  // put your main code here, to run repeatedly:
  //Signal_0 = pulseSensor_0.getLatestSample();
  Signal_0 = analogRead(PulseSensor_0);
  BPM_0 = pulseSensor_0.getBeatsPerMinute();

  Signal_1 = analogRead(PulseSensor_1);
  //Signal_1 = pulseSensor_1.getLatestSample();
  BPM_1 = pulseSensor_1.getBeatsPerMinute();



  Serial.print(Signal_0);
  Serial.print(" ");
  Serial.print(BPM_0);                    // Send the Signal value to Serial Plotter.
  Serial.print(" ");
  Serial.print(Signal_1);
  Serial.print(" ");
  Serial.println(BPM_1);                    // Send the Signal value to Serial Plotter.

  delay(20);

}
