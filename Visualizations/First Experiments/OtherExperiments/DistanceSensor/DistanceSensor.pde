import processing.serial.*;

Serial myPort;  // The serial port

String dataString = "No data";
String[] dataArray = new String[5];
int nl = 10; //ASCII for new line
float distance = 400; //default distance in centimeters

ArrayList<Leaf> Leaves = new ArrayList<Leaf>();

float time =0;
int framerate =30;

void setup() {
  background(255);
  stroke(255);
  size(1200, 1000);
  frameRate(framerate);

  // List all the available serial ports
  //printArray(Serial.list());
  // Open the port you are using at the rate you want:
  String portName = Serial.list()[3];
  //String portName = "/dev/cu.usbmodem142401 (Aurdino uno)";
  myPort = new Serial(this, portName, 9600);
  //getSensorData();

  defineLeaves(50);
}

void draw()
{
  background(255);

  for (Leaf leaf : Leaves)
  {
    drawLeaf(leaf);
  }
  killLeaves();
  if ( int(time*framerate)% 2 == 0) {
    defineLeaves(int(random(5)));
  }
  time +=0.1;
}

void defineLeaves(int numberofLeaves)
{
  for (int i = 0; i < numberofLeaves; i++)
  {
    //print("index " + tree.get(i).finished);
    Leaves.add(new Leaf());
    int j = Leaves.size()-1;
    PVector initCenter = new PVector(random(width), 0);
    Leaves.get(j).setup(initCenter, random(0.5, 1), i);
  }
}

void drawLeaf(Leaf leaf)
{
  leaf.draw();
  updateLeaf(leaf);
}
void updateLeaf(Leaf leaf)
{
  getSensorData();
  float fallRate = height/distance;

  PVector tempCenter = new PVector(0, 0);

  tempCenter.y = leaf.center.y + fallRate; 
  //tempCenter.x = leaf.center.x + sin(radians(time/10))*(width/10);
  tempCenter.x = leaf.center.x;
  leaf.update(tempCenter);
}

void killLeaves()
{
  for (int i = Leaves.size() -1; i>= 0; i--)
  {
    if (Leaves.get(i).life <0)
    {
      Leaves.remove(i);
    }
  }
}

void getSensorData()
{
  while (myPort.available()> 0) {
    dataString = myPort.readStringUntil(nl);
    if (dataString != null) {
      //dataArray = split(dataString, ",");
      if (!Float.isNaN(float(dataString))) {
        distance = float(dataString);
      } else distance = random(0.5, 2);
      println(distance);
      //print(dataArray);
    } 
    //println(dataString);
  }
}
