public class Drop
{
  float x = random(-300, width+300);
  float y = random(-1400, -200);
  float leng = 30 + random(-10, 10);
  float speed = 0;
  float angle = 0;

  void draw() {
    line(x, y, x+leng*sin(this.angle), y+leng*cos(angle));
  }

  void update(float gravity) {
    angle = map(mouseX - 300, -300, 300, -PI / 12, PI / 12);
    y += speed*cos(angle);
    x += speed*sin(angle);
    speed += gravity;
  }

  void reset() {
    x = random(-300, width+300);
    y = random(-800, -200);
    speed = 11;
  }
}
