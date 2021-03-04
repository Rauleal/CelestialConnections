public class Splash
{
  float xPos;

  float a = 0;
  float b = 0;
  float offset = random(4);
  float leng = 4 + random(10);
  boolean over =false;

  Splash(float x) {
    xPos =x;
  }

  void draw() {
    line(xPos - a, height - offset - a, xPos - b, height - offset - b);
    line(xPos + a, height - offset - a, xPos + b, height - offset - b);
  }

  void fade() {
    if (b < leng) {
      b +=4;
    } else if (a < leng) {
      a += 4;
    }
    if (a >= leng && b >= leng) {
      over = true;
    }
  }

  
     
  
}
