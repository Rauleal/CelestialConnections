import processing.serial.*;

Serial myPort;  // The serial port
String dataString = "No data";
String[] dataArray = new String[5];
int nl = 10; //ASCII for new line

float distance =0;
float sensorDistance =500;
float[] distanceArray = new float[frate];
int index  = 0;
float humidity = 0; // humidity
float temperatue = 0; // Read temperature as Celsius (the default)
float hic = 0; // Compute heat index in Celsius (isFahreheit = false)

void getSensorData() {
  while (myPort.available()> 0) {
    dataString = myPort.readStringUntil(nl);
    if (dataString != null) {
      dataArray = split(dataString, " ");
      sensorDistance = float(dataArray[0]);
      //humidity = float(dataArray[1]);
      //temperatue = float(dataArray[2]);
      //hic = float(dataArray[3]);
      //print(dataString);
      print(sensorDistance);
      //print(dataArray); // print data array for debuggin purposes
    }
  }
}
void updateDistanceArray(int index) {
  getSensorData();
  if (!Float.isNaN(distance) && sensorDistance < 500 && sensorDistance >1) {
    distanceArray[index] = sensorDistance;
  }
}

void initializeDistanceArray() {
  for (int i = 0; i < distanceArray.length; i++) {
    distanceArray[i] = sensorDistance;
  }
}

void calculateDistance() {
  float tempDistance = 0;
  //println(distanceArray);

  if (index < distanceArray.length) {
    updateDistanceArray(index);
    index++;
  } else index = 0;

  

  for (int i = 0; i < distanceArray.length; i++) {
    tempDistance += distanceArray[i];
  }
  distance = tempDistance/distanceArray.length;
 println(" "+distance);
}

void sensorSetup() {
  // List all the available serial ports
  //printArray(Serial.list());
  //usually portName = "/dev/cu.usbmodem142401 (Aurdino uno)";
  // blooth port "/dev/tty.HC-06-DevB"
  // Open the port you are using at the rate you want:
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
}
