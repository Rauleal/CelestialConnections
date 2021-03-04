
ArrayList<Leaf> leaves = new ArrayList<Leaf>();
ArrayList<Branch> tree = new ArrayList<Branch>();

//leaf[] leaves = new leaf[100];
//branch[] tree = new branch[100];
float time =0;
int framerate = 60;

void setup()
{
  size(1600, 1000);
  background(255);
  frameRate(framerate);

  PVector begin = new PVector(width/2, height);
  //PVector end = new PVector(begin.x,height/2+100);
  float len =100;
  float thet = 0;
  int parent =0; 
  tree.add(new Branch());
  int index =tree.size()-1;
  tree.get(0).setup(begin, len, thet, index, parent);
  tree.get(0).root = true;

  //tree.get(0).draw();

  defineTree();
  defineLeaves();
  print("laves-" + leaves.size());
  print("branches-" + tree.size());
}

void draw()
{
  background(255);


  updateBranches();
  updateLeaves();
  for (Branch branch : tree)
  {
    branch.draw();
  }
  for (Leaf leaf : leaves)
  {
    leaf.draw();
  }
  time +=1;
}

void defineTree()
{
  for (int j = 0; j < 10; j++)
  {
    for (int i = tree.size()-1; i >= 0; i--)
    {
      if (!tree.get(i).finished) 
      {
        Branch childBranch = new Branch();
        childBranch = tree.get(i).rightChild(i+1);
        tree.add(childBranch);
        childBranch = tree.get(i).leftChild(i+2);
        tree.add(childBranch);
        tree.get(i).finished = true;
      }
    }
  }
}
void defineLeaves()
{
  //for (Branch branch : tree)
  //{
  //  if (!branch.finished)
  //  {
  //    print("index " + branch.finished);
  //    leaves.add(new Leaf());
  //    int i = leaves.size()-1;
  //    leaves.get(i).setup(branch.end, random(0.5, 1),i);
  //  }
  //}
  for (int i = tree.size()-1; i >= 0; i--)
  {
    if (!tree.get(i).finished) 
    {
      //print("index " + tree.get(i).finished);
      leaves.add(new Leaf());
      int j = leaves.size()-1;
      leaves.get(j).setup(tree.get(i).end, random(0.5, 1), i);
    }
  }
}
void updateLeaves()
{
  for (Leaf leaf : leaves)
  {
    if (time > framerate*leaf.life)
    {
      PVector tempCenter = new PVector(0, 0);
      if (leaf.newCenter.y < height - leaf.radius.y) {
        tempCenter.y = leaf.newCenter.y + leaf.fall; 
        tempCenter.x = leaf.center.x + sin(radians(time*random(10)))*random(4)+sin(radians(mouseX))*10;
        leaf.update(tempCenter);
      }
    }
    else leaf.update(tree.get(leaf.branchIndex).end);
  }
}

void updateBranches()
{
  for (int i =1; i < tree.size(); i++)
  {
    Branch branch = tree.get(i);
    int parentIndex = branch.parentIndex; 
    Branch parent = tree.get(parentIndex);

    PVector mouse = new PVector(mouseX, mouseY);
    float theta = PVector.angleBetween(branch.end, mouse);
    //float theta = PVector.angleBetween(new PVector(1,0), mouse);

    branch.update(parent.end, theta);
    //branch.draw();
  }
}

void mouseClicked()
{
  for(int i = tree.size()-1; i>= 0; i--)
  {
    tree.remove(i);
  }
  for(int i = leaves.size()-1; i>=0 ; i--)
  {
    leaves.remove(i);
  }
  defineRoot();
  defineTree();
  defineLeaves();
  time = 0;
}

void defineRoot()
{
  PVector begin = new PVector(mouseX, height);
  float len =Math.min(height - mouseY,mouseY);
  float thet = 0;
  int parent =0; 
  tree.add(new Branch());
  int index =tree.size()-1;
  tree.get(0).setup(begin, len, thet, index, parent);
  tree.get(0).root = true;

  //tree.get(0).draw();
}
