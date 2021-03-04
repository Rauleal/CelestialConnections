//This is second sketch to investigate the use of two disttance sensors
// in this sketch the mouse is used instead
// I still addded the code i uased for the sensors
// Here i am investigting the use of circles and squares 
// oposite to only lines that where used Fearfull Symetry I 
// This code has four main variations with the respective names
// This is Fearfull Symetry II - Circles - No Displacement


int frate = 30;
float rot = 0;

//float angle;
float numSideShapes = 10;
float steps =10;
float strok = 0.1;
float yDisplacement = 0;//0*width/2;

ArrayList<DistanceSensor> distanceSensors = new ArrayList<DistanceSensor>();
int numSensors = 2;

void setup() {
  //size(screen.Width, screen.Height);
  fullScreen();
  stroke(5);
  strokeWeight(strok);
  yDisplacement = 0*width/2;
  //sensorSetup();
  //for (int i = 0; i < numSensors; i++) {
  //  distanceSensors.add(new DistanceSensor());
  //}
  //for (DistanceSensor sensor : distanceSensors) {
  //  sensor.sensorSetUp();
  //}
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
  //float angle = PI/rotations;

  //for (int i = 0; i < numConCircles; i++) {
  pushMatrix();
  for (int index = 1; index < steps; index++) {
    drawSideShapes(numSideShapes*index, index);
  }
  popMatrix();
  //}
}

void drawSideShapes(float numShapes, float index) {
  float radius = width/(index+1);
  float step = TWO_PI/numShapes;
  float angle = 0;
  for (int i = 0; i < numShapes; i++) {
    pushMatrix();
    rotate(angle);
    noFill();
    ellipseMode(CENTER);
    ellipse(0, yDisplacement - width/((index+1)*2), radius, radius);
    //rectMode(CENTER);
    //rect(0, yDisplacement - width/((index+1)*2), radius, radius);
    popMatrix();
    angle += step;
  }
}
void drawConShapes(float numShapes) {
  // this function was used to drow concentrics shapes, it did not seem very fruitfull
  float step = width/numShapes;
  float y = 0;
  while (y < width) {
    y += step;
    noFill();
    //ellipseMode(CENTER);
    //ellipse(0, 0, y, y);
    //rectMode(CENTER);
    //rect(0, 0, y, y);
  }
}

void mouseReleased() {
  redefineParameters();
}

void redefineParameters() {
  //sensor Mode
  //calculateDistances();
  //float distance_0 = distanceSensors.get(0).distanceOutput;
  //float distance_1 = distanceSensors.get(1).distanceOutput;

  //mouse mode
  float distance_0 = mouseY;
  float distance_1 = mouseX;


  defineStroke(distance_0, distance_1);
  defineSteps(distance_0);
  defineNumShapes(distance_1);

  //stroke(random(255),random(255),random(255));
}

void defineStroke(float distance_0, float distance_1) {
  //define stroke
  //float strok= map(mouseX, 0, width, 0, 3);
  float strok= (sin(distance_0/100) + cos(distance_1/80)) + 2;
  strokeWeight(strok*0.5);
  //print(distance+" "+strok +" ");
}

void defineSteps(float distance) {
  //define rotations
  steps = map(distance, 0, height, 0, 20);
  //steps = map(distance, 0, maxDistance, 0, 20);
  //rotations = 50*sin(distance/(100))+50;
  //rotations = 40;
  //println("rotations "+distance+"-"+rotations);
}

void defineNumShapes(float distance) {
  //define number of Lines
  //lines = int(random(10, 40));
  numSideShapes = map(distance, 0, width, 0, 20);
  //numSideShapes = map(distance, 0, maxDistance, 0, 100);
  //lines = 40*cos(distance/100)+40;
  //println("lines "+distance+"-"+lines);
}
