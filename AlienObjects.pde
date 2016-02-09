class AlienObjects
{
  // Vectors for position and movement of alien spaceship
  PVector alienPosition;
  PVector alienMovement;
  // Speed that the alien ship moves across screen
  float alienSpeed;
  // Size of alien ship
  float alienShipWidth;
  float alienShipHeight;
  // Entry point determines the height and side that the alien ship enters from
  int entryPoint;
  // Size of alien laser
  int laserSize; 
  
  AlienObjects()
  {
    alienPosition = new PVector(0, 0);
    alienMovement = new PVector(0, 0);
    alienSpeed = 1.5f;
    alienShipWidth = 25;
    alienShipHeight = alienShipWidth * 0.5f;
    laserSize = 3;
  }

  void render()
  {
  }

  void update()
  {
  }
}