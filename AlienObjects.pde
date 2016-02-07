class AlienObjects
{
  PVector alienPosition;
  PVector alienMovement;
  float alienSpeed;

  float alienShipWidth;
  float alienShipHeight;
  
  int entryPoint;
  
  int laserSize; 
  
  AlienObjects()
  {
    // Position of alien spaceship
    alienPosition = new PVector(0, 0);
    // Vector to control movement of alien ship
    alienMovement = new PVector(0, 0);
    // Speed of alien ship
    alienSpeed = 1.5f;
    // Size of alien ship
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