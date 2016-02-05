class AlienObjects
{
  PVector alienPosition;
  PVector alienMovement;
  float alienSpeed;

  float alienShipWidth;
  float alienShipHeight;
  
  int entryPoint;
  
  AlienObjects()
  {
    alienPosition = new PVector(0, 0);
    alienMovement = new PVector(0, 0);
    
    alienSpeed = 1.5f;

    alienShipWidth = 25;
    alienShipHeight = alienShipWidth * 0.5f;
  }

  void render()
  {
  }

  void update()
  {
  }
}