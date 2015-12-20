class AsteroidObject
{
  PVector position;
  PVector moveShip;
  float speed = 5.0f;
  PVector asteroidMove;
  float astSpeed = 1.5f;
  float theta;
  float shipSize;
  float halfShip;
  
  AsteroidObject()
  {
   this(width * 0.5f, height  * 0.5f, 0);
  }

  AsteroidObject(float x, float y, float size)
  {
    position = new PVector(x, y);
    moveShip = new PVector(0, -1);
    // Set astSpeed dependant on size
    astSpeed /= size;
    // Set random asteroids to go in opposite directions
    if (random(0, 1) > 0.5f)
      astSpeed = -astSpeed; 
    asteroidMove = new PVector(astSpeed, random(-3, 3));
 
    this.theta = 0.0f;
    this.shipSize = 20;
    this.halfShip = shipSize * 0.5f;
  }  

  void render()
  {
  }

  void update()
  {
  }
}