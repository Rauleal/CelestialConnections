/*
Mercury Tilt Switch Module Test

Basic code enabling monitoring the output of the tilt module. 
*/

int switchPin = 4; // select a digital pin for detecting the position of the switch
int state = 0;    // Current state of the tilt switch
//===============================================================================
//  Initialization
//===============================================================================
void setup() 
{ 
  pinMode (switchPin, INPUT);
  Serial.begin (9600);      // Set output window comm rate
}

//===============================================================================
//  Main
//===============================================================================
void loop() 
{
  state = digitalRead (switchPin);
 
  Serial.print ("Current Switch State: ");
  Serial.println (state);
   
  delay(1000);
}
