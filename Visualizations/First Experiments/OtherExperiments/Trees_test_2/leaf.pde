public class Leaf  
{
  PVector center;
  PVector newCenter;
  PVector radius = new PVector(6,6);
  PVector colorfill = new PVector(255,0,0);
  float fall;
  float life;
  int branchIndex;

  void setup(PVector setCenter, float setFall, int index) {
    center = setCenter;
    fall = setFall;
    branchIndex = index;
    newCenter = center;
    radius.x += random(-5,5);
    radius.y += random(-5,5);
    colorfill.x -=random(100);
    colorfill.y +=random(100);
    colorfill.x +=random(100);
    life = random(3,10);
  }

  void draw()
  {
    fill(colorfill.x, colorfill.y, colorfill.z);
    strokeWeight(1);
    stroke(10);
    ellipse(newCenter.x, newCenter.y, radius.x, radius.y);
  }

  void update(PVector tempCenter)
  {
    newCenter.x = tempCenter.x;
    newCenter.y = tempCenter.y;
  }
}
