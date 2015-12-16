class PongObjects
{
  PVector pos;
  float paddleSpeed;
  PVector movePaddle;
  PVector moveBall;

  PongObjects(float startX, float startY)
  {
    pos = new PVector(startX, startY);
    paddleSpeed = 5;
    movePaddle = new PVector(0, paddleSpeed);
    moveBall = new PVector(0, -1);
  }
  
  void render()
  {
  }

  void update()
  {
  }
}