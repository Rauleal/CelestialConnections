//particle ssytem taken from https://www.openprocessing.org/sketch/947145
import processing.serial.*;

Serial myPort;  // The serial port

String dataString = "No data";
String[] dataArray = new String[5];
int nl = 10; //ASCII for new line
float mov = 0; //movement from sensor
float movA = 0; //number of movements
int limit = 40; // limit before action
int maxNumPart = 500; //Maximun Number of particles

float time =0;
int framerate =30;

ArrayList<Particle> Particles = new ArrayList<Particle>();

void setup() {
  background(255);
  stroke(255);
  //fullScreen();
  size(1500, 1000);
  frameRate(framerate);
  noStroke();
  fill(255, 255, 255, 192);

  for (int i =0; i <80; i++) {
    addParticle(random(width), random(height));
  }

  sensorSetup();
  //getSensorData();
}

void draw() {
  background(0);
  getSensorData();
  movA += mov;
  println(movA);
  if (movA > limit) {
    if (Particles.size()>0) {
      Particles.remove(0);
      println("particle killed");
    }
    movA = 0;
  }
  if (movA < -limit) {
    if (Particles.size()< maxNumPart) {
      addParticle(random(width), random(height));
      println("particle added");
    }
    movA = 0;
  
}

calculateParticleRelations();
for (Particle particle : Particles) {
  drawParticle(particle);
}
}

void drawParticle(Particle particle) {
  particle.positionX += particle.velocityX;
  particle.positionY += particle.velocityY;
  particle.draw();
}

void calculateParticleRelations() {
  for (Particle particleA : Particles) {
    float accelerationX = 0;
    float accelerationY = 0;
    for (Particle particleB : Particles) {
      float  distanceX = particleB.positionX - particleA.positionX;
      float distanceY = particleB.positionY - particleA.positionY;

      float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
      if (distance < 1) distance = 1;

      float force = (distance - 400) * particleB.mass / distance;
      accelerationX += force/2 * distanceX;
      accelerationY += force * distanceY;
    }
    particleA.velocityX = particleA.velocityX * 0.99 + accelerationX * particleA.mass;
    particleA.velocityY = particleA.velocityY * 0.99 + accelerationY * particleA.mass;
  }
}

void mousePressed()
{
  addParticle(mouseX, mouseY);
}

void addParticle(float X, float Y) {
  Particles.add(new Particle());
  int j = Particles.size()-1;
  Particles.get(j).define(X, Y);
}
void getSensorData() {
  while (myPort.available()> 0) {
    dataString = myPort.readStringUntil(nl);
    if (dataString != null) {
      //dataArray = split(dataString, ",");
      if (dataString != "NaN") {
        if (float(dataString)>0) {
          mov = 1;
        } else mov = -1;
      } 
      //println(mov);
      //print(dataArray);
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
