int frate = 30;
float rot = 0;

//float angle;
float numSideCircles = 200;
float steps =3;
float strok = 0.1;
float yDisplacement = 0;

ArrayList<DistanceSensor> distanceSensors = new ArrayList<DistanceSensor>();
int numSensors = 2;

void setup() {
  //size(screen.Width, screen.Height);
  fullScreen();
  stroke(5);
  strokeWeight(strok);
  
  yDisplacement = width/2;

  sensorSetup();
  for (int i = 0; i < numSensors; i++) {
    distanceSensors.add(new DistanceSensor());
  }
  for (DistanceSensor sensor : distanceSensors) {
    sensor.sensorSetUp();
  }
}

void draw() {
  float jitter = random(-30, 30);
  stroke(random(30));
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
    drawSideCircles(numSideCircles*index, index);
  }
  popMatrix();
  //}
}

void drawSideCircles(float numCircles, float index) {
  float radius = width/(index+1);
  float step = TWO_PI/numCircles;
  float angle = 0;
  for (int i = 0; i < numCircles; i++) {
    pushMatrix();
    rotate(angle);
    noFill();
    rectMode(CENTER);
    //rect(0, width/2 - width/((index+1)*2), radius, radius);
    rect(0, yDisplacement - width/((index+1)*2), radius, radius);
    popMatrix();
    angle += step;
  }
}

void mouseReleased() {
  redefineParameters();
}

void redefineParameters() {

  //sensor mode
  calculateDistances();

  float distance_0 = distanceSensors.get(0).distanceOutput;
  float distance_1 = distanceSensors.get(1).distanceOutput;
  
  //mouse mode
  //float distance_0 = mouseY;
  //float distance_1 = mouseX;


  defineStroke(distance_0, distance_1);
  defineSteps(distance_0);
  defineNumCircles(distance_1);

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
  //steps = map(distance, 0, height, 0, 100);
  steps = map(distance, 0, maxDistance, 0, 100);
  //steps = 50*sin(distance/(100))+50;
  //rotations = 40;
  //println("rotations "+distance+"-"+rotations);
}

void defineNumCircles(float distance) {
  //define number of Lines
  //lines = int(random(10, 40));
  //numSideCircles = map(distance, 0, width, 0, 100);
  numSideCircles = map(distance, 0, maxDistance, 0, 80);
  //numSideCircles = 40*cos(distance/100)+40;
  //println("lines "+distance+"-"+lines);
}
