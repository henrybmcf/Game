class AsteroidObject
{
  PVector position;
  PVector moveShip;
  float speed = 4.0f;
  PVector asteroidMove;
  float astSpeed = 0.5f;
  float theta;
  float shipHeight;
  float shipWidth;

  float radius;
  
  //AudioPlayer laserSound;
  //AudioPlayer thrustSound;
  //AudioPlayer bigExplosionSound;

  AsteroidObject()
  {
    this(width * 0.5f, height  * 0.5f, 0);
  }

  AsteroidObject(float x, float y, float size)
  {
    position = new PVector(x, y);
    moveShip = new PVector(0, -1);
    // Set astSpeed dependant on size
    astSpeed *= size;
    // Set random asteroids to go in opposite directions
    if (random(1) > 0.5f)
      astSpeed = -astSpeed;
    if (random(1) > 0.5f)
      size = -size;
    // Set movement of asteroid to be random on the y axis, speed dependent on size 
    asteroidMove = new PVector(astSpeed, random(size, size * 2.5));

    this.theta = 0.0f;
    this.shipHeight = 20;
    this.shipWidth = shipHeight * 0.7f;
  }  

  void render()
  {
  }

  void update()
  {
  }
}