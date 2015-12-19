class AsteroidObject
{
  PVector position;
  PVector forward;
  PVector asteroidMove;
  float speed = 15.0f;
  float theta;
  
  //GameObject()
  //{
  //  this(width * 0.5f, height  * 0.5f, 50);
  //}

  AsteroidObject(float x, float y, int size)
  {
    position = new PVector(x, y);
    forward = new PVector(0, -1);
    // Set astSpeed dependant on size
    speed /= size;
    // Set random asteroids to go in opposite directions
    if (random(0, 1) > 0.5f)
      speed = -speed; 
    asteroidMove = new PVector(speed, random(-3, 3));
 
    this.theta = 0.0f;
  }  

  void render()
  {
  }

  void update()
  {
  }
}