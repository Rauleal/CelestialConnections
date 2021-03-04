//this sketch was orginally inteded to work with a distance sensor
//as tis is not posisble online here is the basic porcesing code 
//including the code i used to normalize the input form the sensor

float rot = 0;
float radius;
float pi_divisor =12;
float shadowX;
float eclipseRange = 60;
int op =200;
int r = 0;
float angleMap;
Luna moon = new Luna();

int frate = 30;

void setup() {
  //size(1000, 1200);
  fullScreen();
  frameRate(frate);
  background(0);
  //stroke(255);
  //sensorSetup(); use when using arduino set up
  //initializeDistanceArray();   

  ellipseMode(CENTER);

  moon.defineMoon();
  radius = moon.radius;
  shadowX =-2*radius;
}

void draw() {
  //calculateDistance(); //use for arduino distance sensor
  //shadowX = map(distance, 100, 300, -2*radius, width);
  shadowX = map(mouseX, 0, width, -2*radius, width);
  
  background(0);

  //stroke(255);
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot);
  moon.drawMoon(shadowX, eclipseRange);
  popMatrix();

  pushMatrix();
  translate(width/2, height/2);
  rotate(-PI/pi_divisor);
  if (shadowX < eclipseRange && shadowX >-eclipseRange) {

    angleMap = map(shadowX, -eclipseRange, eclipseRange, 0, PI);
    r = int(255*sin(angleMap));

    angleMap = map(shadowX, -eclipseRange, eclipseRange, -HALF_PI, HALF_PI);
    op = int(255 - 70*cos(angleMap));
  } else {
    r = 0;
    op = 250;
  }
  noStroke();
  float shadowRadius = radius; // use 2* fro full cover
  fill(r, 0, 0, op);
  ellipse(shadowX, 0, 2*shadowRadius, 2*shadowRadius);
  popMatrix();


  rot +=0.005;
}
