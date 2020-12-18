public class DistanceSensor
{
  float distanceOutput =0;
  float sensorDistance = 600;
  float[] distanceArray = new float[frate];
  int indexDisArray  = 0;

  void sensorSetUp() {
    initializeDistanceArray(distanceArray);
  }
  void initializeDistanceArray(float[] array) {
    for (int i = 0; i < array.length; i++) {
      array[i] = minDistance;
    }
  }

  int updateIndex(int index, float[] array) {
    //println("updatingindex");
    if (index < array.length -1) {
      index++;
      return index;
    } else {
      return 0;
    }
  }

  void updateDistanceArray() {
    indexDisArray = updateIndex(indexDisArray, distanceArray);
    
    if (!Float.isNaN(sensorDistance) && sensorDistance < maxDistance && sensorDistance > minDistance) {
      distanceArray[indexDisArray] = sensorDistance;
    }
  }
  void calculateDistance() {
    float tempDistance = 0;
    //println(distanceArray);
    
    updateDistanceArray();

    //println("test " +index);


    //println("test 2 " +index);

    for (int i = 0; i < distanceArray.length; i++) {
      tempDistance += distanceArray[i];
    }
    distanceOutput = tempDistance/distanceArray.length; //distance as everange of distance array
    //println(distance);
  }
}
