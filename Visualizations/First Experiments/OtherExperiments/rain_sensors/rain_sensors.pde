//this sketech is part of the coded nature series. 
//it uses a distance sensor and a humidity sensor DHT11 to make an interactive rainy day.
//sensors data is read from an arduino using th NewPing and adafruit libraries.
//Data is then passed to processing using the srial library. 
//idally the work is not presented in flat screen butin an "enhanched" screen
// for example a screen simulating a window.

import processing.serial.*;

Serial myPort;  // The serial port
String dataString = "No data";
String[] dataArray = new String[5];
int nl = 10; //ASCII for new line

float distance =0;
float humidity = 0; // humidity
float temperatue = 0; // Read temperature as Celsius (the default)
float hic = 0; // Compute heat index in Celsius (isFahreheit = false)


int framerate =40;
ArrayList<Drop> Rain = new ArrayList<Drop>();
ArrayList<Splash> Splashes = new ArrayList<Splash>();
int MaxDrops = 1000;
int initDrops = 100;
int numDrops;

float gravity = 9.8/framerate;



void setup()
{
  fullScreen();
  //size(500, 500);
  frameRate(framerate);
  sensorSetup();
  stroke(255, 200);
  strokeWeight(1.8);
  numDrops = initDrops;
  defineRain(numDrops);
}
void draw()
{
  getSensorData();
  float distanceMap =map(distance, 0, 500, 0, PI);
  int newDrops = int((humidity/100)*MaxDrops * sin(distanceMap))+10;
  background(0, 0, temperatue);
  redefineRain(newDrops);
  for (Drop drop : Rain) {
    drop.draw();
    drop.update(gravity);
    if (drop.y > height) {
      //put splash function
      Splashes.add(new Splash(drop.x));
      drop.reset();
    }
  }
  for (Splash splash : Splashes) {
    splash.fade();
    splash.draw();
  }

  for (int i = Splashes.size() -1; i>= 0; i--)
  {
    if (Splashes.get(i).over)
    {
      Splashes.remove(i);
    }
    //println("a:"+Splashes.get(i).a+" "+"len:"+Splashes.get(i).leng+" "+Splashes.get(i).over);
  }
}

void defineRain(int numberofDrops)
{
  for (int i = 0; i < numberofDrops; i++)
  {
    //print("index " + tree.get(i).finished);
    Rain.add(new Drop());
    //int j = Rain.size()-1;
  }
}

void mousePressed()
{
  redefineRain(int(mouseY));
  
}

void redefineRain(int newDrops){
  if ( numDrops < newDrops) {
    for (int i = Rain.size()-1; i < distance; i++) {
      Rain.add(new Drop());
    }
  } else {
    for (int i = Rain.size()-1; i >= distance; i--) {
      Rain.remove(i);
    }
  }
  numDrops = newDrops;
}


void getSensorData() {
  while (myPort.available()> 0) {
    dataString = myPort.readStringUntil(nl);
    if (dataString != null) {
      dataArray = split(dataString, ",");
      distance = float(dataArray[0]);
      humidity = float(dataArray[1]);
      temperatue = float(dataArray[2]);
      hic = float(dataArray[3]);
      //print(dataString);
      print(dataArray); // print data array for debuggin purposes
    }
  }
}

void sensorSetup() {
  // List all the available serial ports
  //printArray(Serial.list());
  //usually portName = "/dev/cu.usbmodem142401 (Aurdino uno)";
  // Open the port you are using at the rate you want:
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
}
