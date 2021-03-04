float rot = 0;
float radius;
float pi_divisor =12;
float shadowX;
float eclipseRange = 60;
int op =200;
int r = 0;
float angleMap;
Luna moon = new Luna();

void setup() {
  //size(1000, 1200);
  fullScreen();
  background(0);
  //stroke(255);
  ellipseMode(CENTER);
  moon.defineMoon();
  radius = moon.radius;
  shadowX =-2*radius;
}

void draw() {
  background(0);
  
  //stroke(255);
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot);
  moon.drawMoon(shadowX,eclipseRange);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(-PI/pi_divisor);
  if(shadowX < eclipseRange && shadowX >-eclipseRange){
    
    angleMap = map(shadowX,-eclipseRange,eclipseRange,0,PI);
    r = int(255*sin(angleMap));
    
    angleMap = map(shadowX,-eclipseRange,eclipseRange,-HALF_PI,HALF_PI);
    op = int(255 - 70*cos(angleMap));
  }else {
    r = 0;
    op = 250;
  }
  noStroke();
  float shadowRadius = radius; // use 2* fro full cover
  fill(r,0,0,op);
  //ellipse(0,0,2*radius,2*radius);
  ellipse(shadowX,0,2*shadowRadius,2*shadowRadius);
  if(shadowX >width/2){
    moon.killMoon();
    moon.defineMoon();
    pi_divisor = random(1,20);
    shadowX =-2*radius;
  }
  popMatrix();
  

  rot +=0.005;
  shadowX += 1;
}
