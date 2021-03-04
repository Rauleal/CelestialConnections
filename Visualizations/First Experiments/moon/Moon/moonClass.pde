public class Luna
{
  float radius = 400;
  int iterations = int(random(800, 1200));
  int g = 255;
  ArrayList<PVector> moon = new ArrayList<PVector>();

  void defineMoon() {
    for (int i = 0; i < iterations; i++) {  
      float theta1 = random(0, TWO_PI);
      float theta2 = random(0, TWO_PI);
      float stroke = random(200, 255);
      moon.add(new PVector(theta1, theta2, stroke));
    }
  }

  void drawMoon(float shadowX, float eclipseRange) {
    //float theta = map(shadowX, -width, width, 0, PI/2);
    if (-eclipseRange < shadowX && shadowX < eclipseRange) {
      float angleMap = map(shadowX, -width/2, width/2, -HALF_PI, HALF_PI);
      g = int(255 - 255*cos(angleMap));
    } else g =255;
    
    for (PVector line : moon) {
      stroke(line.z, g, g, noise(100, 255)*255);
      line(radius*cos(line.x), radius*sin(line.x), radius*cos(line.y), radius*sin(line.y));
    }
  }
  
  void killMoon(){
    for(int i = moon.size()-1;i >= 0;i--){
      moon.remove(i);
    }
  }
  
}
