public class Branch  
{
  PVector begin;
  PVector end;
  float leng;
  float theta;
  float branchAngle = PI/4;
  float movAngle = 0;
  float reduction = 0.67;
  float str =8;
  int index;
  int parentIndex;
  boolean finished = false;
  boolean root = false;

  void setup(PVector beg, float len, float thet, int ind, int parInd)
  {
    begin = beg;
    leng = len;
    theta = thet;
    index = ind;
    parentIndex = parInd;
    end = endCalculator(begin, leng, theta);
  }
  void draw()
  {
    strokeWeight(str);
    stroke(150);
    line(begin.x, begin.y, end.x, end.y);
    //ellipse(begin.x,begin.y,1,10);
    //ellipse(end.x,end.y,10,1);
  }

  void update(PVector newBegin, float angle)
  {
    begin = newBegin;
    movAngle = angle;
    end = endCalculator(begin, leng, theta+movAngle);
  }

  private PVector endCalculator(PVector beg, float len, float angle)
  {
    PVector tempEnd = new PVector(beg.x,beg.y-len);
    //tempEnd.rotate(thet);
    //PVector tempEnd = new PVector(1,0);
    //PVector tempEnd = new PVector(cos(angle),sin(angle));
    //tempEnd.rotate(angle);
    //tempEnd.mult(len);
    PVector dir = PVector.sub(tempEnd,beg);
    //dir.rotate(theta+movAngle);
    dir.rotate(angle);
    dir.mult(reduction);
    
    PVector newEnd = PVector.add(tempEnd,dir);
    //PVector newEnd = PVector.add(tempEnd,beg);

    return newEnd;
  }
  
  Branch rightChild(int childIndex)
  {
    return childBranch(childIndex, branchAngle);
  }
  Branch leftChild(int childIndex)
  {
    return childBranch(childIndex, -branchAngle);
  }
  Branch childBranch(int childIndex, float branchAngle)
  {
    Branch child = new Branch();
    float angle =branchAngle+theta+random(-0.4,0.4);
    child.setup(end,leng*reduction,angle,childIndex,index);
    
    child.str = 0.7*str;
    child.root = false;
    //finished = true;  
    return child;
  }
}
