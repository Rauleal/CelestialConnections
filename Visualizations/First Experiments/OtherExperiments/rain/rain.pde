int framerate =40;
ArrayList<Drop> Rain = new ArrayList<Drop>();
ArrayList<Splash> Splashes = new ArrayList<Splash>();

float gravity = 9.8/framerate;

void setup()
{
  fullScreen();
  //size(500, 500);
  frameRate(framerate);

  stroke(255, 200);
  strokeWeight(1.8);
  defineRain(100);
}
void draw()
{
  background(0);
  for (Drop drop : Rain) {
    drop.draw();
    drop.update(gravity);
    if (drop.y > height) {
      //put splash function
      Splashes.add(new Splash(drop.x));
      drop.reset();
    }
  }
  for (Splash splash : Splashes) {
    splash.fade();
    splash.draw();
  }

  for (int i = Splashes.size() -1; i>= 0; i--)
  {
    if (Splashes.get(i).over)
    {
      Splashes.remove(i);
    }
    //println("a:"+Splashes.get(i).a+" "+"len:"+Splashes.get(i).leng+" "+Splashes.get(i).over);
  }
}

void defineRain(int numberofDrops)
{
  for (int i = 0; i < numberofDrops; i++)
  {
    //print("index " + tree.get(i).finished);
    Rain.add(new Drop());
    //int j = Rain.size()-1;
  }
}
