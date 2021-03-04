import processing.serial.*;

Serial myPort;  // The serial port
String dataString = "No data";
String[] dataArray = new String[5];
int nl = 10; //ASCII for new line

float maxDistance = 300;
//float maxDistance = width;
float minDistance = 1;


void getSensorData() {
  while (myPort.available()> 0) {
    //println("port available");
    dataString = myPort.readStringUntil(nl);
    if (dataString != null) {
      dataArray = split(dataString, " ");
      //println("got sensor data");
      println("t" +dataArray);
      for (int i = 0; i < distanceSensors.size(); i++) {
        distanceSensors.get(i).sensorDistance = float(dataArray[i]);
      }
    } else println("no sensor data");
  }
}


void calculateDistances() {
  getSensorData();
  //print("debug");

  for (DistanceSensor sensor : distanceSensors) {
    sensor.calculateDistance();
  }

  //index_0 = calculateIndex(index_0, distanceArray_0);
  //distance_0 = calculateDistance(distanceArray_0, index_0, sensorDistance_0);

  //index_1 = calculateIndex(index_1, distanceArray_1);
  //distance_1 = calculateDistance(distanceArray_1, index_1, sensorDistance_1);
  //println("in0 " + index_0 + " " + "in1 " + index_1);
}

void sensorSetup() {
  // List all the available serial ports
  printArray(Serial.list());
  //usually portName = "/dev/cu.usbmodem142401 (Aurdino uno)";
  // blooth port "/dev/tty.HC-06-DevB"
  // Open the port you are using at the rate you want:
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);

  //intialize data array
  for (int i = 0; i < dataArray.length; i++) {
    dataArray[i] = " ";
  }
}
