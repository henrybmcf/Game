class AsteroidObject
{
  // Vectors for position of ship and asteroids
  PVector position;
  // Vector for movement of ship
  PVector moveShip;
  float speed;
  // Vector ror movement of asteroid
  PVector asteroidMove;
  float astSpeed;
  // Direction ship is facing
  float facingAngle;
  // Size of ship
  float shipHeight;
  float shipWidth;
  // Size of asteroid
  float radius;
  // Controls swapping of every other laser
  boolean colourSwap;
  // Controls swapping of thrust colour to simulate flame
  boolean thrustColour;

  AsteroidObject()
  {
    this(width * 0.5f, height * 0.5f, 0);
  }

  AsteroidObject(float x, float y, float size)
  {
    position = new PVector(x, y);
    moveShip = new PVector(0, -1);
    speed = 4.0f;
    // Set asteroid speed dependant on size
    if (size == 1)
      astSpeed = 0.25f;
    else if (size == 2)
      astSpeed = 0.35f;
    else if (size == 3)
      astSpeed = 0.4f;
    // Set random asteroids to go in opposite directions
    if (random(1) > 0.5f)
      astSpeed = -astSpeed;
    if (random(1) > 0.5f)
      size = -size;
    // Set movement of asteroid to be random on the y axis, speed dependent on size
    if (random(1) > 0.5f)
      asteroidMove = new PVector(astSpeed, random(size, size * 1.5));
    else
      asteroidMove = new PVector(random(-size, -size * 1.5), astSpeed);

    this.facingAngle = 0.0f;
    this.shipHeight = 18;
    this.shipWidth = shipHeight * 0.7f;
  }  

  void render()
  {
  }

  void update()
  {
  }
}