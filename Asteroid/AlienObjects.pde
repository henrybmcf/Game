class AlienObjects
{
  PVector position;
  PVector movement;
  float speed;

  float facingAngle;
  float sw;
  float sh;
  
  int entryPoint;
  
  AlienObjects()
  {
    position = new PVector(0, 0);
    movement = new PVector(0, 0);
    
    speed = 1.5f;

    sw = 25;
    sh = sw * 0.5f;
  }

  void render()
  {
  }

  void update()
  {
  }
}