class AlienObjects
{
  PVector position;
  PVector movement;
  float speed;

  float facingAngle;
  float alienShipWidth;
  float alienShipHeight;
  
  int entryPoint;
  
  AlienObjects()
  {
    position = new PVector(0, 0);
    movement = new PVector(0, 0);
    
    speed = 1.5f;

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