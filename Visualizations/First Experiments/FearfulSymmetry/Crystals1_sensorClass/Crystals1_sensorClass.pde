// This sketch was inteded to work with two distance sensors in an arduino
// in this sketch the mouse is used instead
// I still addded the code i uased for the sensors

int frate = 30;
float rot = 0;

//float angle;
float rotations = 6;
float lines =40;
float strok = 5;

ArrayList<DistanceSensor> distanceSensors = new ArrayList<DistanceSensor>();
int numSensors = 2;

void setup() {
  //size(screen.Width, screen.Height);
  fullScreen();
  stroke(5);
  strokeWeight(strok);

  sensorSetup();
  for (int i = 0; i < numSensors; i++) {
    distanceSensors.add(new DistanceSensor());
  }
  for (DistanceSensor sensor : distanceSensors) {
    sensor.sensorSetUp();
  }
}

void draw() {
  float jitter = random(-20, 20);
  background(200, jitter, jitter);
  redefineParameters();
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot);
  drawPattern();
  popMatrix();
  rot += 0.005;
}

void drawPattern() {
  float angle = PI/rotations;
  for (int i = 0; i < rotations; i++) {
    pushMatrix();
    //translate(width/2, height/2);
    rotate(angle*i);
    grid(lines);
    popMatrix();
  }
}

void grid(float numLines) {
  float step = height/numLines;
  float y = -height - step/2;
  while (y < height) {
    y += step;
    line(-width, y, width, y);
  }
}

void mouseReleased() {
  //redefineParameters();
}

void redefineParameters() {
  
  calculateDistances();
  float distance_0 = distanceSensors.get(0).distanceOutput;
  float distance_1 = distanceSensors.get(1).distanceOutput;

  defineStroke(distance_0, distance_1);
  defineRotations(distance_1);
  defineLines(distance_0);

  //stroke(random(255),random(255),random(255));
}

void defineStroke(float distance_0, float distance_1) {
  //define stroke
  //float strok= map(mouseX, 0, width, 0, 3);
  float strok= (sin(distance_0/100) + cos(distance_1/80)) + 2;
  strokeWeight(strok);
  //print(distance+" "+strok +" ");
}

void defineRotations(float distance) {
  //define rotations
  //rotations = map(mouseY, 0, height, 0, 100);
  rotations = map(distance, 0, maxDistance, 0, 100);
  //rotations = 50*sin(distance/(100))+50;
  //rotations = 40;
  println("rotations "+distance+"-"+rotations);
}

void defineLines(float distance) {
  //define number of Lines
  //lines = int(random(10, 40));
  lines = map(distance, 0, maxDistance, 0, 60);
  //lines = 40*cos(distance/100)+40;
  println("lines "+distance+"-"+lines);
}
