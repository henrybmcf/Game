class PongObjects
{
  PVector pos;
  float speed;
  PVector movePaddle;
  PVector moveBall;
  float theta;

  PongObjects(float startX, float startY)
  {
    pos = new PVector(startX, startY);
    speed = 5;
    movePaddle = new PVector(0, speed);
    moveBall = new PVector(0, 0);
    this.theta = 1.0f;
  }
  
  void render()
  {
  }

  void update()
  {
  }
}