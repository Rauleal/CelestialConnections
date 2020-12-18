int led = 7;

void setup() {
Serial.begin(9600);
pinMode(led, OUTPUT);
}

void loop() {
int sensorValue = analogRead(A0);
int newValeu = map(sensorValue, 0, 1023, 0, 255);
analogWrite(led, newValeu);
}
