public class Particle  
{
float mass;
float positionX;
float positionY;
float velocityX;
float velocityY;

void define(float X, float Y) {
  mass =random(0.003, 0.03);
  positionX = X;
  positionY = Y;
  velocityX = 0;
  velocityY = 0;
}

void draw(){
  ellipse(positionX, positionY, mass * 100, mass * 1000);
}

}
