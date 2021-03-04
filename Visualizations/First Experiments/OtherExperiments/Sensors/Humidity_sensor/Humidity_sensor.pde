import processing.serial.*;

Serial myPort;  // The serial port

String dataString = "No data";
String[] dataArray = new String[5];
int nl = 10; //ASCII for new line

float hum = 0;
float temp = 0;
float tempF = 0;
float heatIn =0;
float heatInF =0;

void setup() {
  background(0);
  stroke(255);
  size(1200, 1000);
  // List all the available serial ports
  //printArray(Serial.list());
  // Open the port you are using at the rate you want:
  String portName = Serial.list()[3];
  //String portName = "/dev/cu.usbmodem142401 (Aurdino uno)";
  myPort = new Serial(this, portName, 9600);
  getSensorData();
}

void draw() {
  background(0);
  getSensorData();

  text("Hum: " + hum, 10, 30);
  text("temp: " + temp, 10, 40);
  text("tempF: " + tempF, 10, 50);
  text("heatIn: " + heatIn, 10, 60);
  text("heatInF: " + heatIn, 10, 70);

  line(width/2, height/2, hum, temp);
}

void getSensorData()
{
  while (myPort.available()> 0) {
    dataString = myPort.readStringUntil(nl);
    if (dataString != null) {
      dataArray = split(dataString, ",");
      hum = float(dataArray[0]);
      temp = float(dataArray[1]);
      tempF = float(dataArray[2]);
      heatIn = float(dataArray[3]);
      heatInF = float(dataArray[4]);
      //print(dataArray);
    }
  }
}
